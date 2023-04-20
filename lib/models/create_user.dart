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
}
