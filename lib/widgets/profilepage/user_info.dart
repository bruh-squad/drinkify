import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/utils/theming.dart';
import '/widgets/dialogs/success_sheet.dart';
import '/models/friend.dart';
import '/models/user.dart';

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
  bool get _isMyProfile => widget.user != null;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Profile picture
        Column(
          children: [
            //TODO fix friend pfp loading
            _isMyProfile
                ? widget.user!.pfp != null
                    ? CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(widget.user!.pfp!),
                        backgroundColor: Theming.bgColorLight,
                      )
                    : const CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage("assets/images/default_pfp.png"),
                        backgroundColor: Theming.bgColorLight,
                      )
                : widget.friend!.pfp != null
                    ? CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(widget.friend!.pfp!),
                        backgroundColor: Theming.bgColorLight,
                      )
                    : const CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage("assets/images/default_pfp.png"),
                        backgroundColor: Theming.bgColorLight,
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
                    ? "@${widget.user!.username}"
                    : "@${widget.friend!.username}",
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
            //sending a friend request
            const storage = FlutterSecureStorage();
            final userId = await storage.read(key: "user_publicId");
            if (widget.user!.publicId! == userId && mounted) {
              showModalBottomSheet(
                  context: context,
                  useRootNavigator: true,
                  backgroundColor: Theming.bgColor,
                  builder: (ctx) {
                    return SuccessSheet(
                      success: false,
                      successMsg:
                          AppLocalizations.of(context)!.successFriendInvite,
                      failureMsg:
                          AppLocalizations.of(context)!.failureFriendInvite,
                    );
                  });
            }
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
              AppLocalizations.of(context)!.addAFriend,
              style: Styles.buttonTextLight,
            ),
          ),
        ),
      ],
    );
  }
}
