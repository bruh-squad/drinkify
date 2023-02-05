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
  final Map<double, double> lnglat;
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

final Map<double, double> testLngLat = {12.3333: 13.33333};

final List<Party> listOfParties = [
  Party(
    owner: 'Kamil',
    name: '18 Kamila',
    privacyStatus: PrivacyStatus.public,
    description: "Podstawowy opis imprezy",
    participants: ['Szymon', 'Oliwier', 'Bartek'],
    localisation: 'ul. Bakałarza 15A',
    lnglat: testLngLat,
    startTime: DateTime.now(),
    endTime: DateTime.now(),
  ),
];
