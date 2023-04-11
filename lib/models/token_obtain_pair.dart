import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../utils/consts.dart' show mainUrl;

class TokenObtainPair {
  final String email;
  final String password;

  TokenObtainPair({
    required this.email,
    required this.password,
  });

  Future<http.Response> getToken() async {
    Uri url = Uri.parse("$mainUrl/auth/token/");

    var res = await http.post(
      url,
      body: jsonEncode(
        {
          "email": email,
          "password": password,
        },
      ),
      headers: {
        "Content-Type": "application/json",
      },
    );

    final Map<String, String> resValues = jsonDecode(res.body);
    const storage = FlutterSecureStorage();
    await storage.write(
      key: "auth-token",
      value: resValues["access"],
    );
    await storage.write(
      key: "auth-refresh",
      value: resValues["refresh"],
    );

    return res;
  }
}
