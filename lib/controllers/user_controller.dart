import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../utils/consts.dart';
import '../utils/ext.dart' show DateTimeConvert;
import '../models/user.dart';
import '../models/friend_invitiation.dart';
import '../models/party_invitation.dart';

///Used for getting information about the user, updating, deleting and searching
class UserController {
  ///Returns information about you
  static Future<User> me() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "access");

    final url = "$mainUrl/users/";
    final res = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    final json = jsonDecode(res.body);
    return User.fromMap(json);
  }

  ///Deletes user's account, returns **true** if succeded and **false** if failed
  static Future<bool> deleteMe() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "access");
    final url = "$mainUrl/users/";
    final res = await http.delete(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    if (res.statusCode == 204) {
      await storage.delete(key: "access");
      await storage.delete(key: "refresh");
      return true;
    }
    return false;
  }

  ///Updates user's account
  static Future<bool> updateMe(User user) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "access");
    final url = "$mainUrl/users/";

    final Map<String, String> json = {
      "first_name": user.firstName ?? "",
      "last_name": user.lastName ?? "",
      "date_of_birth": user.dateOfBirth!.toYMD(),
      "password": user.password!,
    };
    json.removeWhere((k, v) {
      return v.isEmpty && k != "password" && k != "date_of_birth";
    });

    final req = http.MultipartRequest(
      "PATCH",
      Uri.parse(url),
    );
    req.fields.addAll(json);
    req.headers.addAll({
      "Content-Type": "multipart/form-data",
      "Authorization": "Bearer $token",
    });
    if (user.pfp != null) {
      req.files.add(
        http.MultipartFile(
          "pfp",
          File(user.pfp!).readAsBytes().asStream(),
          File(user.pfp!).lengthSync(),
          filename: user.pfp!,
          contentType: MediaType("image", "jpeg"),
        ),
      );
    }

    final res = await req.send();
    return res.statusCode == 200;
  }

  static Future<bool> sendFriendInvitation(FriendInvitation inv) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "access");
    final url = "$mainUrl/friends/invitations/";
    final res = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        "sender": {},
        "receiver": {},
        "receiver_public_id": inv.receiverPublicId,
        "sender_public_id": inv.senderPublicId,
      }),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    return res.statusCode == 201;
  }

  ///Retrieves a list of friend invitaions
  static Future<List<FriendInvitation>> friendInvitations() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "access");
    final url = "$mainUrl/friends/invitations/";
    final res = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    final invitations = <FriendInvitation>[];
    for (final fi in jsonDecode(res.body)["results"]) {
      invitations.add(FriendInvitation.fromMap(fi));
    }

    return invitations;
  }

  ///Retrieves a list of party invitations
  static Future<List<PartyInvitation>> partyInvitations() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "access");
    final url = "$mainUrl/parties/invitations/";
    final res = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    final invitations = <PartyInvitation>[];
    for (final pi in jsonDecode(res.body)["results"]) {
      invitations.add(PartyInvitation.fromMap(pi));
    }

    return invitations;
  }
}
