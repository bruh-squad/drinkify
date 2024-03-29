import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '/utils/theming.dart';
import '/widgets/dialogs/success_sheet.dart';
import '/models/friend.dart';
import '/models/user.dart';
import '/models/friend_invitiation.dart';
import '/controllers/user_controller.dart';

class UserInfo extends StatefulWidget {
  final User? user;
  final Friend? friend;
  const UserInfo(
    this.user,
    this.friend, {
    super.key,
  });

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  bool get _isMyProfile => widget.friend == null;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Profile picture
        Column(
          children: [
            _isMyProfile
                ? widget.user?.pfp != null
                    ? CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(widget.user!.pfp!),
                        backgroundColor: Theming.bgColorLight,
                      )
                    : Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          color: Theming.bgColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 2,
                            color: Theming.whiteTone.withOpacity(0.3),
                          ),
                        ),
                        child: Icon(
                          Icons.person_rounded,
                          size: 50,
                          color: Theming.whiteTone.withOpacity(0.3),
                        ),
                      )
                : widget.friend?.pfp != null
                    ? CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(widget.friend!.pfp!),
                        backgroundColor: Theming.bgColorLight,
                      )
                    : Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          color: Theming.bgColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 2,
                            color: Theming.whiteTone.withOpacity(0.3),
                          ),
                        ),
                        child: Icon(
                          Icons.person_rounded,
                          size: 50,
                          color: Theming.whiteTone.withOpacity(0.3),
                        ),
                      ),

            const SizedBox(height: 10),

            //Username
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 7,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: Theming.whiteTone.withOpacity(0.1),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                _isMyProfile
                    ? "@${widget.user?.username ?? ""}"
                    : "@${widget.friend?.username ?? ""}",
                style: const TextStyle(
                  color: Theming.greenTone,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        //Add friend
        GestureDetector(
          onTap: () async {
            const storage = FlutterSecureStorage();
            final userId = await storage.read(key: "user_publicId");
            if (_isMyProfile) {
              if (!mounted) return;
              context.push("/edit-profile");
              return;
            }
            final success = await UserController.sendFriendInvitation(
              FriendInvitation(
                receiverPublicId: widget.friend!.publicId!,
                senderPublicId: userId!,
                createdAt: DateTime.now(),
              ),
            );
            if (!mounted) return;
            showModalBottomSheet(
                context: context,
                useRootNavigator: true,
                backgroundColor: Theming.bgColor,
                builder: (ctx) {
                  return SuccessSheet(
                    success: success,
                    successMsg:
                        AppLocalizations.of(context)!.successFriendInvite,
                    failureMsg:
                        AppLocalizations.of(context)!.failureFriendInvite,
                  );
                });
          },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width - 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theming.primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              _isMyProfile
                  ? AppLocalizations.of(context)!.editProfile
                  : AppLocalizations.of(context)!.addAFriend,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Theming.whiteTone,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
