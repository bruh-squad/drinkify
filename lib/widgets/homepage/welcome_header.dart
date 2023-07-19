import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/utils/theming.dart';
import '/models/user.dart';
import '/controllers/user_controller.dart';
import '/models/friend_invitiation.dart';
import '/models/party_invitation.dart';
import '/models/party_request.dart';

class WelcomeHeader extends StatefulWidget {
  final User user;
  const WelcomeHeader(this.user, {super.key});

  @override
  State<WelcomeHeader> createState() => _WelcomeHeaderState();
}

class _WelcomeHeaderState extends State<WelcomeHeader> {
  late List<FriendInvitation> friendInvs;
  late List<PartyInvitation> partyInvs;
  late List<PartyRequest> partyReqs;
  late int totalNotifs;

  @override
  void initState() {
    super.initState();
    friendInvs = [];
    partyInvs = [];
    partyReqs = [];
    totalNotifs = 0;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final friendInvsTemp = await UserController.friendInvitations();
      final partyInvsTemp = await UserController.partyInvitations();
      final partyReqsTemp = await UserController.joinRequests();
      setState(() {
        friendInvs = friendInvsTemp;
        partyInvs = partyInvsTemp;
        partyReqs = partyReqsTemp;
        totalNotifs =
            friendInvs.length + partyInvsTemp.length + partyReqsTemp.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => context.push(
                  "/notifications",
                  extra: [
                    friendInvs,
                    partyInvs,
                    partyReqs,
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${AppLocalizations.of(context)!.welcomeHeader}${widget.user.firstName ?? "..."}',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Theming.whiteTone,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${AppLocalizations.of(context)!.youHave} $totalNotifs ${AppLocalizations.of(context)!.notifications}",
                      style: const TextStyle(
                        color: Theming.primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => context.push("/settings"),
                child: widget.user.pfp != null
                    ? CircleAvatar(
                        radius: 28,
                        backgroundImage: NetworkImage(widget.user.pfp!),
                        backgroundColor: Theming.bgColorLight,
                      )
                    : const CircleAvatar(
                        radius: 28,
                        backgroundImage:
                            AssetImage("assets/images/default_pfp.png"),
                        backgroundColor: Theming.bgColorLight,
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
