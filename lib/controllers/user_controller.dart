import 'dart:convert';

import 'package:drinkify/models/friend.dart';
import 'package:http/http.dart' as http;

import '../utils/consts.dart';
import '../models/user.dart';

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
    //TODO remove password from User model
    return User(
      publicId: json["public_id"],
      username: json["username"],
      email: json["email"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      dateOfBirth: json["date_of_birth"],
      pfp: json["pfp"],
      friends: json["friends"] as List<Friend>,
      password: "",
    );
  }
}
