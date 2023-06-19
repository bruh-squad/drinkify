import 'dart:convert';
import 'package:drinkify/models/friend.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../utils/consts.dart';
import '../models/party.dart';
import '../models/party_invitation.dart';
import '../utils/ext.dart' show ParseFromPOINT;

///Used by the regular user to join, leave, accept party requests and more
class PartyController {
  ///Sends a join request to the [party]
  static Future<void> sendJoinRequest(Party party) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "access");

    //TODO implement
    final url = "$mainUrl/";
    await http.post(
      Uri.parse(url),
      body: {},
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
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
    final invitations = <PartyInvitation>[
      for (final e in jsonDecode(res.body)["results"] as List)
        PartyInvitation(
          party: Party(
            publicId: e["party"]["public_id"],
            ownerPublicId: e["party"]["owner_public_id"],
            owner: Friend(
              publicId: e["party"]["owner"]["public_id"],
              username: e["party"]["owner"]["username"],
              firstName: e["party"]["owner"]["first_name"],
              lastName: e["party"]["owner"]["last_name"],
              dateOfBirth: e["party"]["owner"]["date_of_birth"],
              pfp: e["party"]["owner"]["pfp"],
            ),
            name: e["party"]["name"],
            description: e["party"]["description"],
            location: (e["party"]["location"] as String).toLatLng(),
            startTime: DateTime.parse(e["party"]["start_time"]),
            stopTime: DateTime.parse(e["party"]["stop_time"]),
            distance: e["party"]["distance"],
            image: e["party"]["image"],
            privacyStatus: e["party"]["privacy_status"],
            privacyStatusDisplay: e["party"]["privacy_status_display"],
            participants: [
              for (final p in e["party"]["participants"] as List)
                Friend(
                  publicId: p["public_id"],
                  username: p["username"],
                  firstName: p["first_name"],
                  lastName: p["last_name"],
                  dateOfBirth: p["date_of_birth"],
                  pfp: p["pfp"],
                ),
            ],
          ),
          partyPublicId: e["party_public_id"],
          receiverPublicId: e["receiver_public_id"],
          createdAt: e["created_at"],
          receiver: Friend(
            publicId: e["receiver"]["public_id"],
            username: e["receiver"]["username"],
            firstName: e["receiver"]["first_name"],
            lastName: e["receiver"]["last_name"],
            dateOfBirth: e["receiver"]["date_of_birth"],
            pfp: e["receiver"]["pfp"],
          ),
        ),
    ];
    return invitations;
  }
}
