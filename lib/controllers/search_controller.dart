import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../utils/consts.dart';
import '../models/friend.dart';
import '../models/party.dart';

///Used for searching parties and users
class SearchController {
  ///Retrieves user's data based on provided [publicId]
  static Future<Friend> searchUser(String publicId) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "access");

    final url = "$mainUrl/users/$publicId";
    final res = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    return Friend.fromMap(jsonDecode(res.body));
  }

  static Future<List<Party>> seachPartiesByDistance(double meters) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "access");
    final url = "$mainUrl/parties/?range=$meters";
    final res = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    final parties = <Party>[
      for (final p in jsonDecode(res.body)) Party.fromMap(p),
    ];
    return parties;
  }
}
