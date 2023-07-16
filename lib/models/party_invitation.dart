import './friend.dart';
import './party.dart';

class PartyInvitation {
  final int? id;
  final Party? party;
  final String partyPublicId;
  final Friend? receiver;
  final String receiverPublicId;
  final DateTime? createdAt;

  const PartyInvitation({
    this.id,
    this.party,
    required this.partyPublicId,
    this.receiver,
    required this.receiverPublicId,
    this.createdAt,
  });

  factory PartyInvitation.fromMap(Map<String, dynamic> m) {
    return PartyInvitation(
      id: m["id"],
      party: Party.fromMap(m["party"]),
      partyPublicId: m["party_public_id"],
      receiver: Friend.fromMap(m["receiver"]),
      receiverPublicId: m["receiver_public_id"],
      createdAt: DateTime.parse(m["created_at"]),
    );
  }
}
