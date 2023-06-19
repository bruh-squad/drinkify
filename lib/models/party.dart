import 'package:latlong2/latlong.dart';

import './friend.dart';

enum PrivacyStatus {
  private,
  public,
  secret,
}

class Party {
  final String? publicId;
  final Friend? owner;
  final String ownerPublicId;
  final String name;
  final PrivacyStatus? privacyStatus;
  final String? privacyStatusDisplay;
  final String description;
  final String? image;
  final List<Friend>? participants;
  final LatLng location;
  final String? distance;
  final DateTime startTime;
  final DateTime stopTime;

  const Party({
    this.publicId,
    this.owner,
    required this.ownerPublicId,
    required this.name,
    this.privacyStatus,
    this.privacyStatusDisplay,
    required this.description,
    this.image,
    this.participants,
    required this.location,
    this.distance,
    required this.startTime,
    required this.stopTime,
  });
}
