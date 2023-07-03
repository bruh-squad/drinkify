import './friend.dart';

class FriendInvitation {
  final int? id;
  final Friend? sender;
  final Friend? receiver;
  final String receiverPublicId;
  final String senderPublicId;
  final DateTime? createdAt;

  const FriendInvitation({
    this.id,
    this.sender,
    this.receiver,
    required this.receiverPublicId,
    required this.senderPublicId,
    this.createdAt,
  });

  factory FriendInvitation.fromMap(Map<String, dynamic> m) {
    return FriendInvitation(
      id: m["id"],
      receiver: Friend.fromMap(m["receiver"]),
      sender: Friend.fromMap(m["sender"]),
      receiverPublicId: m["receiver_public_id"],
      senderPublicId: m["sender_public_id"],
      createdAt: DateTime.parse(m["created_at"]),
    );
  }
}
