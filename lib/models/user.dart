import '../utils/ext.dart';
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

  factory User.fromMap(Map<String, dynamic> m) {
    if (m["public_id"] == null) return const User();

    return User(
      publicId: m["public_id"],
      username: m["username"],
      email: m["email"],
      firstName: m["first_name"],
      lastName: m["last_name"],
      dateOfBirth: (m["date_of_birth"] as String).toDateTime(),
      pfp: m["pfp"],
      friends: [
        for (final f in m["friends"]) Friend.fromMap(f),
      ],
    );
  }

  factory User.emptyUser() {
    return const User(
      username: "",
      firstName: "",
      lastName: "",
      friends: [],
    );
  }

  @override
  String toString() {
    return "$username $email $firstName $lastName $dateOfBirth";
  }
}
