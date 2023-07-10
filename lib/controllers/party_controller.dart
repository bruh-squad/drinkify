import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_parser/http_parser.dart';

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
      body: {
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
      },
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    return res.statusCode == 201;
  }

  ///Leaves from the provided [party]
  static Future<void> leaveParty(Party party) async {}

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

  ///Creates a party using information provided in [party]
  static Future<bool> createParty(Party party) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "access");
    final url = "$mainUrl/parties/";
    final req = http.MultipartRequest("POST", Uri.parse(url));
    req.fields.addAll(<String, String>{
      "owner_public_id": party.ownerPublicId!,
      "name": party.name,
      "privacy_status": party.privacyStatus.toString(),
      "description": party.description,
      "location": party.location!.toPOINT(),
      "start_time": party.startTime.toIso8601String(),
      "stop_time": party.stopTime.toIso8601String(),
      "participants":
          jsonEncode([for (final p in party.participants!) p.toMap()]),
    });
    req.headers.addAll({
      "Content-Type": "multipart/form-data",
      "Authorization": "Bearer $token",
    });
    if (party.image != null) {
      req.files.add(
        http.MultipartFile(
          "image",
          File(party.image!).readAsBytes().asStream(),
          File(party.image!).lengthSync(),
          filename: party.image!,
          contentType: MediaType("image", "jpeg"),
        ),
      );
    }
    final res = await req.send();
    return res.statusCode == 201;
  }
}
