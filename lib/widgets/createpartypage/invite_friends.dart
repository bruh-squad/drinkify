import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/utils/theming.dart';
import '/models/user.dart';
import '/routes/create_party_routes/invite_friends_page.dart';

class InviteFriends extends StatefulWidget {
  final Function(List<User>) onFinish;
  const InviteFriends({
    required this.onFinish,
    super.key,
  });

  @override
  State<InviteFriends> createState() => _InviteFriendsState();
}

class _InviteFriendsState extends State<InviteFriends> {
  late List<User> invitedUsers;

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
            color: Theming.whiteTone.withOpacity(0.3),
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
    required User userData,
  }) {
    return Container(
      height: 50,
      width: 50,
      margin: EdgeInsets.only(left: index * 25),
      decoration: const BoxDecoration(
        color: Theming.primaryColor,
        shape: BoxShape.circle,
        //Acts like a better border
        boxShadow: [
          BoxShadow(
            color: Theming.bgColor,
            spreadRadius: 4,
          ),
        ],
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            "https://avatars.githubusercontent.com/u/63369072?v=4",
          ),
        ),
      ),
    );
  }
}
