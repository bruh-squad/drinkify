import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import './friend.dart';
import '../utils/consts.dart' show mainUrl;

class User {
  final String? publicId;
  final String? username;
  final String? email;
  final String? firstName;
  final String? lastName;
  final DateTime dateOfBirth;
  final String? pfp;
  final List<Friend>? friends;
  final String password;

  User({
    this.publicId,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    required this.dateOfBirth,
    this.pfp,
    this.friends,
    required this.password,
  });

  static Future<http.Response> deleteUser() async {
    final Uri url = Uri.parse("$mainUrl/users/");

    const storage = FlutterSecureStorage();
    final String? jwt = await storage.read(key: "auth-token");

    return await http.delete(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $jwt",
      },
    );
  }
}
