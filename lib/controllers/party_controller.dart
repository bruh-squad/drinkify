import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../utils/consts.dart';
import '../models/party.dart';
import '../models/party_invitation.dart';
import '../utils/ext.dart' show LatLngConvert;

///Used by the regular user to join, leave, accept party requests and more
class PartyController {
  ///Sends a join request to the [party]
  static Future<bool> sendJoinRequest(Party party) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "access");
    final userId = await storage.read(key: "user_publicId");
    final url = "$mainUrl/parties/requests/${party.publicId}/";
    final res = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        "party": {
          "owner": {},
          "owner_public_id": party.ownerPublicId,
          "name": party.name,
          "privacy_status": party.privacyStatus,
          "description": party.description,
          "location": party.location!.toPOINT(),
          "start_time": party.startTime.toIso8601String(),
          "stop_time": party.stopTime.toIso8601String(),
        },
        "party_public_id": party.publicId,
        "sender": {},
        "sender_public_id": userId,
      }),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    return res.statusCode == 201;
  }

  ///Returns all party invitation user has got
  static Future<List<PartyInvitation>> invitations() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "access");
    final url = "$mainUrl/parties/invitations/";
    final res = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    if (res.statusCode != 200) return [];
    final invitations = <PartyInvitation>[];
    for (final pi in jsonDecode(res.body)["results"]) {
      invitations.add(PartyInvitation.fromMap(pi));
    }
    return invitations;
  }

  static Future<List<Party>> myParties() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "access");
    final url = "$mainUrl/parties/";
    final res = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    final parties = <Party>[
      for (final p in jsonDecode(res.body)["results"]) Party.fromMap(p),
    ];
    return parties;
  }

  // FIXME url
  static Future<bool> acceptPartyInvitation(PartyInvitation inv) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "access");
    final url = "$mainUrl/parties/invitations/${inv.partyPublicId}/${inv.id}";
    final res = await http.post(
      Uri.parse(url),
      body: {
        "party": {
          "owner": {},
          "owner_public_id": inv.party!.ownerPublicId,
          "name": inv.party!.name,
          "privacy_status": inv.party!.privacyStatus,
          "description": inv.party!.description,
          "location": inv.party!.location!.toPOINT(),
          "start_time": inv.party!.startTime.toIso8601String(),
          "stop_time": inv.party!.stopTime.toIso8601String(),
        },
        "party_public_id": inv.partyPublicId,
        "receiver": {},
        "receiver_public_id": inv.receiverPublicId,
      },
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    return res.statusCode == 201;
  }

  // FIXME url
  static Future<bool> rejectPartyInvitation(PartyInvitation inv) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "access");
    final url = "$mainUrl/parties/invitations/${inv.partyPublicId}/${inv.id}";
    final res = await http.delete(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    return res.statusCode == 204;
  }
}
