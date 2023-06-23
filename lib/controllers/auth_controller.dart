import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../utils/consts.dart';
import '../models/create_user.dart';

///Used for logging in and signing up a user
class AuthController {
  ///Used only for logging in
  TextEditingController emailCtrl = TextEditingController();

  ///Used only for logging in
  TextEditingController passwordCtrl = TextEditingController();

  ///Handles logging in
  Future<bool> loginUser() async {
    final url = "$mainUrl/auth/token/";
    final res = await http.post(
      Uri.parse(url),
      body: {
        "email": emailCtrl.text,
        "password": passwordCtrl.text,
      },
    );

    if (res.statusCode == 200) {
      final loginArr = json.decode(res.body);
      const storage = FlutterSecureStorage();
      await storage.write(
        key: "access",
        value: loginArr["access"],
      );
      await storage.write(
        key: "refresh",
        value: loginArr["refresh"],
      );
      return true;
    }
    return false;
  }

  ///Handles the creation of new user
  static Future<bool> registerUser(CreateUser user) async {
    final url = "$mainUrl/users/";
    final dOB = user.dateOfBirth!;

    final res = await http.post(
      Uri.parse(url),
      body: {
        "username": user.username,
        "email": user.email,
        "first_name": user.firstName,
        "last_name": user.lastName,
        "date_of_birth": "${dOB.year}-${dOB.month}-${dOB.day}",
        "password": user.password,
        "pfp": user.pfp!,
      },
    );
    return res.statusCode == 201;
  }
}
