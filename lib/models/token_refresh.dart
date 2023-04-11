import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../utils/consts.dart' show mainUrl;

class TokenRefresh {
  final String refresh;
  final String? access;

  TokenRefresh({
    required this.refresh,
    this.access,
  });

  Future<http.Response> getRefresh() async {
    Uri url = Uri.parse("$mainUrl/auth/token/refresh/");
    Map<String, String?> bodyToEncode = {
      "refresh": refresh,
      "access": access,
    };
    bodyToEncode.removeWhere((_, val) => val == null);

    var res = await http.post(
      url,
      body: jsonEncode(bodyToEncode),
      headers: {
        "Content-Type": "application/json",
      },
    );
    final Map<String, String> resValues = jsonDecode(res.body);
    const storage = FlutterSecureStorage();
    await storage.write(
      key: "auth-refresh",
      value: resValues["refresh"],
    );

    return res;
  }
}
