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
  final LatLng lnglat;
  final DateTime startTime;
  final DateTime endTime;

  Party({
    required this.owner,
    required this.name,
    required this.privacyStatus,
    required this.description,
    required this.participants,
    required this.localisation,
    required this.lnglat,
    required this.startTime,
    required this.endTime,
  });
}

final List<Party> listOfParties = [
  Party(
    owner: 'Kamil',
    name: '18 Kamila',
    privacyStatus: PrivacyStatus.public,
    description: "Podstawowy opis imprezy",
    participants: ['Szymon', 'Oliwier', 'Bartek'],
    localisation: 'ul. Bakałarza 15A',
    lnglat: LatLng(51.40253, 21.14714),
    startTime: DateTime.now(),
    endTime: DateTime.now(),
  ),
  Party(
    owner: 'Oliwier',
    name: '18 Oliwiera',
    privacyStatus: PrivacyStatus.public,
    description: "Podstawowy opis imprezy",
    participants: ['Szymon', 'Oliwier', 'Bartek'],
    localisation: 'ul. Bakałarza 15A',
    lnglat: LatLng(51.40253, 21.14714),
    startTime: DateTime.now(),
    endTime: DateTime.now(),
  ),
  Party(
    owner: 'Adam',
    name: '18 Adama',
    privacyStatus: PrivacyStatus.public,
    description: "2 Podstawowy opis imprezy",
    participants: ['Szymon', 'Oliwier', 'Bartek'],
    localisation: 'ul. Malarza 15A',
    lnglat: LatLng(51.40253, 21.14714),
    startTime: DateTime.now(),
    endTime: DateTime.now(),
  ),
  Party(
    owner: 'Szymon',
    name: '18 Szymona',
    privacyStatus: PrivacyStatus.public,
    description: "2 Podstawowy opis imprezy",
    participants: ['Szymon', 'Oliwier', 'Bartek'],
    localisation: 'ul. Malarza 15A',
    lnglat: LatLng(51.40253, 21.14714),
    startTime: DateTime.now(),
    endTime: DateTime.now(),
  ),
];
