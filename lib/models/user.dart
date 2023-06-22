import './friend.dart';

class User {
  final String? publicId;
  final String? username;
  final String? email;
  final String? firstName;
  final String? lastName;
  final DateTime? dateOfBirth;
  final String? pfp;
  final List<Friend>? friends;
  final String? password;

  const User({
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

  @override
  String toString() {
    return "$username $email $firstName $lastName $dateOfBirth";
  }
}
