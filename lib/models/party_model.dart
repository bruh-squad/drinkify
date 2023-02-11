import 'package:latlong2/latlong.dart';

enum PrivacyStatus {
  private,
  public,
  secret,
}

class Party {
  final String owner;
  final String name;
  final PrivacyStatus privacyStatus;
  final String description;
  final List<String> participants;
  final String localisation;
  final LatLng latlng;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;

  Party({
    required this.owner,
    required this.name,
    required this.privacyStatus,
    required this.description,
    required this.participants,
    required this.localisation,
    required this.latlng,
    required this.date,
    required this.startTime,
    required this.endTime,
  });
}
