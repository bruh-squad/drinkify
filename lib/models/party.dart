import 'package:latlong2/latlong.dart';

import './friend.dart';
import '../utils/ext.dart';

class Party {
  final String? publicId;
  final Friend? owner;
  final String? ownerPublicId;
  final String name;
  final int? privacyStatus;
  final String? privacyStatusDisplay;
  final String description;
  final String? image;
  final List<Friend>? participants;
  final LatLng? location;
  final int? distance;
  final DateTime startTime;
  final DateTime stopTime;

  const Party({
    this.publicId,
    this.owner,
    this.ownerPublicId,
    required this.name,
    this.privacyStatus,
    this.privacyStatusDisplay,
    required this.description,
    this.image,
    this.participants,
    this.location,
    this.distance,
    required this.startTime,
    required this.stopTime,
  });

  factory Party.fromMap(Map<String, dynamic> m) {
    // print(m["participants"]);
    return Party(
      publicId: m["public_id"],
      owner: Friend.fromMap(m["owner"]),
      ownerPublicId: m["owner_public_id"],
      name: m["name"],
      description: m["description"],
      startTime: DateTime.parse(m["start_time"] as String),
      stopTime: DateTime.parse(m["stop_time"] as String),
      distance: m["distance"],
      location: (m["location"] as String).toLatLngReceive(),
      privacyStatus: m["privacy_status"],
      privacyStatusDisplay: m["privacy_status_display"],
      image: m["image"],
      participants: [for (final p in m["participants"]) Friend.fromMap(p)],
    );
  }

  @override
  String toString() {
    return "$name ${owner?.username} $privacyStatusDisplay $location $startTime $stopTime";
  }
}
