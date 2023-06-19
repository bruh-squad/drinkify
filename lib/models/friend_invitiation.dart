import './friend.dart';

class FriendInvitation {
  final int? id;
  final Friend? sender;
  final Friend? receiver;
  final String receiverPublicId;
  final String senderPublicId;
  final String? createdAt;

  const FriendInvitation({
    this.id,
    this.sender,
    this.receiver,
    required this.receiverPublicId,
    required this.senderPublicId,
    this.createdAt,
  });
}
