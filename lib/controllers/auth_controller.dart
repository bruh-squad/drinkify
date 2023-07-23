import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../utils/ext.dart' show DateTimeConvert;

import '../utils/consts.dart';
import '../models/create_user.dart';

///Used for logging in and signing up a user
class AuthController {
  AuthController._();

  ///Handles logging in
  static Future<bool> loginUser(
    String email,
    String password,
    bool rememberMe,
  ) async {
    final url = "$mainUrl/auth/token/";
    final res = await http.post(
      Uri.parse(url),
      body: {
        "email": email,
        "password": password,
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
      await storage.write(
        key: "remember",
        value: "$rememberMe",
      );
      return true;
    }
    return false;
  }

  ///Handles the creation of new user
  static Future<bool> registerUser(CreateUser user) async {
    final url = "$mainUrl/users/";

    final req = http.MultipartRequest(
      "POST",
      Uri.parse(url),
    );
    req.headers.addAll({"Content-Type": "multipart/form-data"});
    req.fields.addAll(
      {
        "username": user.username!,
        "email": user.email!,
        "first_name": user.firstName!,
        "last_name": user.lastName!,
        "date_of_birth": user.dateOfBirth!.toYMD(),
        "password": user.password!,
      },
    );
    if (user.pfp != null) {
      req.files.add(
        http.MultipartFile(
          "pfp",
          user.pfp!.readAsBytes().asStream(),
          user.pfp!.lengthSync(),
          filename: user.pfp!.path,
          contentType: MediaType("image", "jpeg"),
        ),
      );
    }
    final res = await req.send();
    return res.statusCode == 201;
  }
}
