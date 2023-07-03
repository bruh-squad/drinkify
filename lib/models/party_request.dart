import './friend.dart';
import './party.dart';

class PartyRequest {
  final Party? party;
  final String partyPublicId;
  final Friend? sender;
  final String senderPublicId;
  final DateTime? createdAt;

  const PartyRequest({
    this.party,
    required this.partyPublicId,
    this.sender,
    required this.senderPublicId,
    this.createdAt,
  });

  factory PartyRequest.fromMap(Map<String, dynamic> m) {
    return PartyRequest(
      party: Party.fromMap(m["party"]),
      partyPublicId: m["party_public_id"],
      sender: Friend.fromMap(m["sender"]),
      senderPublicId: m["sender_public_id"],
      createdAt: DateTime.parse(m["created_at"]),
    );
  }
}
