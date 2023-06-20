import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../utils/consts.dart';
import '../models/user.dart';

///Used for getting information about the user, updating, deleting and searching.
class UserController {
  ///Returns information about you.
  static Future<User> me() async {
    final url = "$mainUrl/users/";
    final res = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer",
      },
    );
    final json = jsonDecode(res.body);
    return User(
      publicId: json["public_id"],
      username: json["username"],
      email: json["email"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      dateOfBirth: json["date_of_birth"],
      pfp: json["pfp"],
      friends: json["friends"],
      password: "", //Do NOT change this value
    );
  }

  ///Deletes user's account
  static Future<void> deleteMe() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "access");
    final url = "$mainUrl/users/";
    await http.delete(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
  }

  ///Updates user's account
  static Future<void> updateMe() async {}
}
