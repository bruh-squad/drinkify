import 'package:drinkify/controllers/party_controller.dart';
import 'package:drinkify/controllers/party_creator_controller.dart';
import 'package:drinkify/controllers/user_controller.dart';
import 'package:drinkify/models/friend_invitiation.dart';
import 'package:drinkify/models/party_invitation.dart';
import 'package:drinkify/models/party_request.dart';
import 'package:drinkify/widgets/dialogs/success_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/utils/theming.dart';

///Used for displaying all information about a notification
class NotificationSheet extends StatefulWidget {
  final Object notif;
  const NotificationSheet(
    this.notif, {
    super.key,
  });

  @override
  State<NotificationSheet> createState() => _NotificationSheetState();
}

class _NotificationSheetState extends State<NotificationSheet> {
  void _modalSheet(
    BuildContext context,
    bool success,
    bool isAccept,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theming.bgColor,
      builder: (ctx) => SuccessSheet(
        success: success,
        successMsg: isAccept
            ? AppLocalizations.of(context)!.acceptedNotif
            : AppLocalizations.of(ctx)!.rejectedNotif,
        failureMsg: AppLocalizations.of(ctx)!.acceptRejectError,
      ),
    );
  }

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
                    Visibility(
                      visible: widget.notif is! PartyRequest,
                      child: GestureDetector(
                        onTap: () async {
                          //TODO
                          if (widget.notif is FriendInvitation) {
                            final success =
                                await UserController.acceptFriendInvitation(
                              widget.notif as FriendInvitation,
                            );
                            if (!mounted) return;
                            _modalSheet(context, success, true);
                          }
                          if (widget.notif is PartyInvitation) {
                            final success =
                                await PartyController.acceptPartyInvitation(
                              widget.notif as PartyInvitation,
                            );
                            if (!mounted) return;
                            _modalSheet(context, success, true);
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
                    ),
                    GestureDetector(
                      onTap: () async {
                        //TODO
                        if (widget.notif is FriendInvitation) {
                          final success =
                              await UserController.rejectFriendInvitation(
                            widget.notif as FriendInvitation,
                          );
                          if (!mounted) return;
                          _modalSheet(context, success, false);
                        }
                        if (widget.notif is PartyInvitation) {
                          final success =
                              await PartyController.rejectPartyInvitation(
                            widget.notif as PartyInvitation,
                          );
                          if (!mounted) return;
                          _modalSheet(context, success, false);
                        }
                        if (widget.notif is PartyRequest) {
                          final success =
                              await PartyCreatorController.rejectPartyRequest(
                            widget.notif as PartyRequest,
                          );
                          if (!mounted) return;
                          _modalSheet(context, success, false);
                        }
                      },
                      child: Container(
                        width: widget.notif is PartyRequest
                            ? MediaQuery.of(context).size.width - 60
                            : MediaQuery.of(context).size.width / 2 - 40,
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
