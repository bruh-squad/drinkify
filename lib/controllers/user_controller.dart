import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../utils/consts.dart';
import '../models/user.dart';
import '../models/friend.dart';
import '../utils/ext.dart' show StrConvert, DateTimeConvert;

///Used for getting information about the user, updating, deleting and searching
class UserController {
  ///Returns information about you
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
    return User(
      publicId: json["public_id"],
      username: json["username"],
      email: json["email"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      dateOfBirth: (json["date_of_birth"] as String).toDateTime(),
      pfp: json["pfp"],
      friends: [
        for (final e in json["friends"])
          Friend(
            publicId: e["public_id"],
            username: e["username"],
            firstName: e["first_name"],
            lastName: e["last_name"],
            dateOfBirth: (e["date_of_birth"] as String).toDateTime(),
            pfp: e["pfp"],
          ),
      ],
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
    if (res.statusCode == 204) {
      await storage.delete(key: "access");
      await storage.delete(key: "refresh");
      return true;
    }
    return false;
  }

  ///Updates user's account
  static Future<bool> updateMe(User user) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "access");
    final url = "$mainUrl/users/";

    final Map<String, dynamic> json = {
      "first_name": user.firstName,
      "last_name": user.lastName,
      "date_of_birth": user.dateOfBirth!.toYMD(),
      "password": user.password,
    };
    json.removeWhere((k, v) {
      return v == null && k != "password" && k != "date_of_birth";
    });

    final res = await http.patch(
      Uri.parse(url),
      body: json,
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    return res.statusCode == 200;
  }
}
