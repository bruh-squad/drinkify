import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:drinkify/utils/consts.dart';
import '../models/friend.dart';

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
    final json = jsonDecode(res.body);
    final searchedUser = Friend(
      publicId: json["public_id"],
      username: json["username"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      dateOfBirth: json["date_of_birth"],
      pfp: json["pfp"],
    );

    return searchedUser;
  }
}
