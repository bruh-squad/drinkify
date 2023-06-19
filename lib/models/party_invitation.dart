import './friend.dart';
import './party.dart';

class PartyInvitation {
  final Party? party;
  final String partyPublicId;
  final Friend? receiver;
  final String receiverPublicId;
  final DateTime? createdAt;

  const PartyInvitation({
    this.party,
    required this.partyPublicId,
    this.receiver,
    required this.receiverPublicId,
    this.createdAt,
  });
}
