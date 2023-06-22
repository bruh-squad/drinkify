class Friend {
  final String? publicId;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? dateOfBirth;
  final String? pfp;

  const Friend({
    this.publicId,
    this.username,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.pfp,
  });

  @override
  String toString() {
    return "$username $firstName $lastName $dateOfBirth";
  }
}
