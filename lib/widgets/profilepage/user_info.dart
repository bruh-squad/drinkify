import 'package:drinkify/widgets/dialogs/success_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/utils/theming.dart';
import '/models/user.dart';

class UserInfo extends StatefulWidget {
  final User? user;
  const UserInfo(
    this.user, {
    super.key,
  });

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Parties attended / Profile pic with username / Friends
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 100,
              child: Column(
                children: [
                  const Text(
                    "10",
                    style: TextStyle(
                      color: Theming.whiteTone,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.partiesProfile1,
                    style: TextStyle(
                      color: Theming.whiteTone.withOpacity(0.5),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            //Profile picture
            Column(
              children: [
                widget.user!.pfp != null
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
                    "@${widget.user!.username}",
                    style: const TextStyle(
                      color: Theming.greenTone,
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () => context.push(
                "/friend-list",
                extra: widget.user!.friends!,
              ),
              child: SizedBox(
                width: 100,
                child: Column(
                  children: [
                    Text(
                      "${widget.user!.friends != null ? widget.user!.friends!.length : 0}",
                      style: const TextStyle(
                        color: Theming.whiteTone,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.friendsProfile,
                      style: TextStyle(
                        color: Theming.whiteTone.withOpacity(0.5),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
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
