import 'dart:io';

import './friend.dart';

class CreateUser {
  final String? publicId;
  final String? username;
  final String? email;
  final String? firstName;
  final String? lastName;
  final DateTime? dateOfBirth;
  final File? pfp;
  final List<Friend>? friends;
  final String? password;

  const CreateUser({
    this.publicId,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.pfp,
    this.friends,
    this.password,
  });
}
