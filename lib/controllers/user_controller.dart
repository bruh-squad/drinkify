import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../utils/consts.dart';
import '../models/user.dart';
import '../models/friend.dart';

///Used for getting information about the user, updating, deleting and searching.
class UserController {
  ///Returns information about you.
  static Future<User> me() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "access");
    final url = "$mainUrl/users/";
    final res = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    final json = jsonDecode(res.body);
    final friends = <Friend>[
      for (final e in json["friends"])
        Friend(
          publicId: e["public_id"],
          username: e["username"],
          firstName: e["first_name"],
          lastName: e["last_name"],
          pfp: e["pfp"],
          dateOfBirth: e["date_of_birth"],
        ),
    ];
    return User(
      publicId: json["public_id"],
      username: json["username"],
      email: json["email"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      dateOfBirth: DateTime.parse(json["date_of_birth"]),
      pfp: json["pfp"],
      friends: friends,
    );
  }

  ///Deletes user's account, returns **true** if succeded and **false** if failed
  static Future<bool> deleteMe() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "access");
    final url = "$mainUrl/users/";
    final res = await http.delete(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    return res.statusCode == 204;
  }

  ///Updates user's account
  static Future<void> updateMe() async {}
}
