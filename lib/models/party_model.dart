enum PrivacyStatus {
  private,
  public,
  secret,
}

class Party {
  final String owner;
  final String name;
  final PrivacyStatus privacy_status;
  final String description;
  final List<String> participants;
  final String localisation;
  final Map<double, double> lnglat;
  final DateTime start_time;
  final DateTime end_time;

  Party({
    required this.owner,
    required this.name,
    required this.privacy_status,
    required this.description,
    required this.participants,
    required this.localisation,
    required this.lnglat,
    required this.start_time,
    required this.end_time,
  });
}

final Map<double, double> testlnglat = {12.3333: 13.33333};

final List<Party> ListOfParties = [
  Party(
    owner: 'Kamil',
    name: '18 Kamila',
    privacy_status: PrivacyStatus.public,
    description: "Podstawowy opis imprezy",
    participants: ['Szymon', 'Oliwier', 'Bartek'],
    localisation: 'ul. Bakałarza 15A',
    lnglat: testlnglat,
    start_time: DateTime.now(),
    end_time: DateTime.now(),
  ),
];
