import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../utils/consts.dart' show mainUrl;
import '../models/party.dart';
import '../models/party_request.dart';
import '../utils/ext.dart' show LatLngConvert;

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

    final parties = <Party>[];
    for (final e in jsonDecode(res.body)["results"]) {
      parties.add(Party.fromMap(e));
    }
    return parties;
  }

  ///Creates a party
  static Future<bool> createParty(Party p) async {
    final url = "$mainUrl/parties/";
    final res = await http.post(
      Uri.parse(url),
      body: {
        "owner": {},
        "owner_public_id": p.ownerPublicId,
        "name": p.name,
        "privacy_status": p.privacyStatus,
        "description": p.description,
        "location": p.location!.toPOINT(),
        "start_time": p.startTime.toIso8601String(),
        "stop_time": p.stopTime.toIso8601String(),
      },
    );

    return res.statusCode == 201;
  }

  ///Retrieves a list of join requests to user's owned parties
  static Future<List<PartyRequest>> joinRequests() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "access");
    final url = "$mainUrl/parties/requests/";
    final res = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    final requests = <PartyRequest>[];
    for (final pr in jsonDecode(res.body)["results"]) {
      requests.add(PartyRequest.fromMap(pr));
    }
    return requests;
  }
}
