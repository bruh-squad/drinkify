import '../utils/ext.dart';

class Friend {
  final String? publicId;
  final String? username;
  final String? firstName;
  final String? lastName;
  final DateTime? dateOfBirth;
  final String? pfp;

  const Friend({
    this.publicId,
    this.username,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.pfp,
  });

  factory Friend.fromMap(Map<String, dynamic> m) {
    if (m["public_id"] == null) return const Friend();

    return Friend(
      publicId: m["public_id"],
      username: m["username"],
      firstName: m["first_name"],
      lastName: m["last_name"],
      dateOfBirth: (m["date_of_birth"] as String).toDateTime(),
      pfp: m["pfp"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "public_id": publicId,
      "username": username,
      "first_name": firstName,
      "last_name": lastName,
      "date_of_birth": dateOfBirth!.toYMD(),
      "pfp": pfp,
    };
  }

  @override
  String toString() {
    return "$username $firstName $lastName $dateOfBirth";
  }
}
