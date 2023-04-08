import 'package:http/http.dart' as http;
import '../utils/consts.dart' show mainUrl;

import './friend.dart';

class CreateUser {
  final String? publicId;
  final String username;
  final String email;
  final String? firstName;
  final String? lastName;
  final DateTime dateOfBirth;
  final Uri? pfp;
  final List<Friend>? friends;
  final String password;

  CreateUser({
    this.publicId,
    required this.username,
    required this.email,
    this.firstName,
    this.lastName,
    required this.dateOfBirth,
    this.pfp,
    this.friends,
    required this.password,
  });

  Future<http.Response> createUser() async {
    Uri url = Uri.parse("$mainUrl/users/");

    return await http.post(
      url,
      body: {
        "username": username,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "date_of_birth": dateOfBirth.toString(),
        "password": password,
      },
      headers: {
        "Content-Type": "application/json",
      },
    );
  }
}
