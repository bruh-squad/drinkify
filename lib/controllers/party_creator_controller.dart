import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../utils/consts.dart' show mainUrl;
import '../models/friend.dart';
import '../models/party.dart';

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
      for (final e in jsonDecode(res.body)["results"] as List)
        Party(
          publicId: e["public_id"],
          owner: Friend(
            publicId: e["owner"]["public_id"],
            username: e["owner"]["username"],
            firstName: e["owner"]["first_name"],
            lastName: e["owner"]["last_name"],
            pfp: e["owner"]["pfp"],
            dateOfBirth: e["owner"]["date_of_birth"],
          ),
          ownerPublicId: e["owner_public_id"],
          name: e["name"],
          privacyStatus: e["privacy_status"],
          privacyStatusDisplay: e["privacy_status_display"],
          description: e["description"],
          image: e["image"],
          participants: [
            for (final p in jsonDecode(e["participants"]) as List)
              Friend(
                publicId: p["public_id"],
                username: p["username"],
                firstName: p["first_name"],
                lastName: p["last_name"],
                pfp: p["pfp"],
                dateOfBirth: p["date_of_birth"],
              ),
          ],
          location: e["location"],
          distance: e["distance"],
          startTime: DateTime.parse(e["start_time"]),
          stopTime: DateTime.parse(e["stop_time"]),
        ),
    ];
    return parties;
  }
}
