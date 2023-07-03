import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../utils/consts.dart' show mainUrl;
import '../models/party.dart';
import '../models/party_request.dart';

///Used by the party creator to control owned parties
class PartyCreatorController {
  ///Returns a list of all parties created by the user
  static Future<List<Party>> ownedParties() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "access");
    final url = "$mainUrl/parties/mine/";
    final res = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    final parties = <Party>[
      for (final e in jsonDecode(res.body)["results"]) Party.fromMap(e),
    ];
    return parties;
  }

  ///Creates a party
  static Future<void> createParty(Party party) async {}

  ///Retrieves a list of join requests to user's owned parties
  static Future<List<PartyRequest>> joinRequests() async {
    final requests = <PartyRequest>[];
    return requests;
  }
}
