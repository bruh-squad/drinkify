import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../utils/consts.dart';
import '../models/party.dart';

class PartyController {
  static Future<void> sendJoinRequest(Party party) async {
    const storage = FlutterSecureStorage();
    final token = storage.read(key: "access");

    final url = "$mainUrl/";
    await http.post(
      Uri.parse(url),
      body: {
        //TODO implement
      },
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
  }

  static Future<void> leaveParty(Party party) async {}
  static Future<void> ownedParties() async {
    const storage = FlutterSecureStorage();
    final token = storage.read(key: "access");
    final url = "$mainUrl/parties/mine/";
    await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
  }

  static Future<void> invitations() async {}
}
