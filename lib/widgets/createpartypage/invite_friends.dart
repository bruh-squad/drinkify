import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/utils/theming.dart';
import '/routes/create_party_routes/invite_friends_page.dart';
import '/models/friend.dart';

class InviteFriends extends StatefulWidget {
  final Function(List<Friend>) onFinish;
  const InviteFriends({
    required this.onFinish,
    super.key,
  });

  @override
  State<InviteFriends> createState() => _InviteFriendsState();
}

class _InviteFriendsState extends State<InviteFriends> {
  late List<Friend> invitedUsers;

  @override
  void initState() {
    super.initState();
    invitedUsers = [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.invitedFriends.toUpperCase(),
          style: TextStyle(
            color: Theming.whiteTone.withOpacity(0.5),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) {
                  return InviteFriendsPage(
                    onFinish: (users) {
                      setState(() => invitedUsers = users);
                      widget.onFinish(invitedUsers);
                    },
                  );
                },
              ),
            );
          },
          child: SizedBox(
            height: 55,
            width: double.infinity,
            child: invitedUsers.isEmpty
                ? Text(
                    AppLocalizations.of(context)!.noFriendsInvited,
                    style: TextStyle(
                      color: Theming.whiteTone.withOpacity(0.6),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Stack(
                      children: [
                        for (int i = 0; i < invitedUsers.length; i++)
                          _userPlaceholder(
                            i,
                            allUsers: invitedUsers.length,
                            userData: invitedUsers[i],
                          ),
                      ],
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _userPlaceholder(
    int index, {
    required int allUsers,
    required Friend userData,
  }) {
    return Visibility(
      visible: index <= 9,
      child: Container(
        height: 50,
        width: 50,
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: index * 25),
        decoration: BoxDecoration(
          color: Theming.primaryColor,
          shape: BoxShape.circle,
          //Acts like a better border
          boxShadow: const [
            BoxShadow(
              color: Theming.bgColor,
              spreadRadius: 4,
            ),
          ],
          image: index < 9
              ? DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    userData.pfp!,
                  ),
                )
              : null,
        ),
        child: Text(
          index < 9 ? "" : "+${allUsers - index}",
          style: const TextStyle(
            color: Theming.whiteTone,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
