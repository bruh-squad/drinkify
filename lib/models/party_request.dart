import './friend.dart';
import './party.dart';

class PartyRequest {
  final int? id;
  final Party? party;
  final String partyPublicId;
  final Friend? sender;
  final String senderPublicId;
  final DateTime? createdAt;

  const PartyRequest({
    this.id,
    this.party,
    required this.partyPublicId,
    this.sender,
    required this.senderPublicId,
    this.createdAt,
  });

  factory PartyRequest.fromMap(Map<String, dynamic> m) {
    return PartyRequest(
      id: m["id"],
      party: Party.fromMap(m["party"]),
      partyPublicId: m["party_public_id"] ?? "",
      sender: Friend.fromMap(m["sender"]),
      senderPublicId: m["sender_public_id"] ?? "",
      createdAt: DateTime.parse(m["created_at"]),
    );
  }

  @override
  String toString() => "$id $partyPublicId $senderPublicId $createdAt";
}
