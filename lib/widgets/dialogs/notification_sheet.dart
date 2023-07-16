import 'package:drinkify/controllers/party_controller.dart';
import 'package:drinkify/controllers/party_creator_controller.dart';
import 'package:drinkify/controllers/user_controller.dart';
import 'package:drinkify/models/friend_invitiation.dart';
import 'package:drinkify/models/party_invitation.dart';
import 'package:drinkify/models/party_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/utils/theming.dart';

///Used for displaying all information about a notification
class NotificationSheet extends StatelessWidget {
  final Object notif;
  const NotificationSheet(
    this.notif, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Stack(
            children: [
              const Wrap(
                children: [
                  //TODO implement info about notification
                ],
              ),
              SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        //TODO
                        if (notif is FriendInvitation) {
                          final success =
                              await UserController.acceptFriendInvitation(
                            notif as FriendInvitation,
                          );
                        }
                        if (notif is PartyInvitation) {
                          final success =
                              await PartyController.acceptPartyInvitation(
                            notif as PartyInvitation,
                          );
                        }
                        if (notif is PartyRequest) {
                          final success =
                              await PartyCreatorController.acceptPartyRequest(
                            notif as PartyRequest,
                          );
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2 - 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theming.greenTone.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.acceptNotif,
                          style: const TextStyle(
                            color: Theming.greenTone,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        //TODO
                        if (notif is FriendInvitation) {
                          final success =
                              await UserController.rejectFriendInvitation(
                            notif as FriendInvitation,
                          );
                        }
                        if (notif is PartyInvitation) {
                          final success =
                              await PartyController.rejectPartyInvitation(
                            notif as PartyInvitation,
                          );
                        }
                        if (notif is PartyRequest) {
                          final success =
                              await PartyCreatorController.rejectPartyRequest(
                            notif as PartyRequest,
                          );
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2 - 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Theming.errorColor.withOpacity(0.2),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.rejectNotif,
                          style: const TextStyle(
                            color: Theming.errorColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
