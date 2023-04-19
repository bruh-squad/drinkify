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
}
