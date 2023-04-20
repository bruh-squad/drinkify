import './friend.dart';
import './party.dart';

class PartyRequest {
  final Party? party;
  final String partyPublicId;
  final Friend? sender;
  final String senderPublicId;
  final DateTime? createdAt;

  PartyRequest({
    this.party,
    required this.partyPublicId,
    this.sender,
    required this.senderPublicId,
    this.createdAt,
  });
}
