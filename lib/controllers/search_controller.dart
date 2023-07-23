import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

import '../utils/consts.dart';
import '../models/friend.dart';
import '../models/party.dart';
import '../utils/ext.dart';

///Used for searching parties and users
class SearchController {
  SearchController._();

  ///Retrieves user's data based on provided [username]
  static Future<List<Friend>> searchUserByUsername(String username) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "access");

    final url = "$mainUrl/users/search?q=$username";
    final res = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    final users = <Friend>[];
    for (final u in jsonDecode(res.body)["results"]) {
      users.add(Friend.fromMap(u));
    }
    return users;
  }

  static Future<Friend> searchUserByPublicId(String id) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "access");
    final url = "$mainUrl/users/$id/";
    final res = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    return Friend.fromMap(jsonDecode(res.body));
  }

  static Future<List<Party>> seachPartiesByDistance({
    double meters = 1000,
    required LatLng location,
  }) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "access");
    final url = "$mainUrl/parties/?range=$meters";
    final res = await http.get(
      Uri.parse(url),
      headers: {
        "Point": location.toPOINT(),
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    final parties = <Party>[];
    for (final p in jsonDecode(res.body)["results"]) {
      parties.add(Party.fromMap(p));
    }
    return parties;
  }
}
