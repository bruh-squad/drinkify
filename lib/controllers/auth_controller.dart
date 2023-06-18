import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../utils/consts.dart';
import '../models/create_user.dart';

class AuthController {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  Future<void> loginUser() async {
    final url = '$mainUrl/auth/token/';
    final response = await http.post(
      Uri.parse(url),
      body: {
        "email": emailCtrl.text,
        "password": passwordCtrl.text,
      },
    );

    if (response.statusCode == 200) {
      final loginArr = json.decode(response.body);
      const storage = FlutterSecureStorage();
      await storage.write(
        key: 'access',
        value: loginArr['access'],
      );
      await storage.write(
        key: 'refresh',
        value: loginArr['refresh'],
      );
      return debugPrint(loginArr);
    }
    debugPrint("${response.statusCode}");
  }

  Future<void> registerUser(CreateUser user) async {
    final response = await http.post(
      Uri.parse('$mainUrl/users/'),
      body: {
        "username": user.username,
        "email": user.email,
        "first_name": user.firstName,
        "last_name": user.lastName,
        "date_of_birth":
            '${user.dateOfBirth.year}-${user.dateOfBirth.month}-${user.dateOfBirth.day}',
        "password": user.password,
      },
    );
    if (response.statusCode == 200) {
      return debugPrint(json.decode(response.body));
    }
    debugPrint("${response.statusCode}");
  }
}
