import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/utils/theming.dart';
import '/controllers/party_controller.dart';
import '/controllers/party_creator_controller.dart';
import '/controllers/user_controller.dart';
import '/models/friend_invitiation.dart';
import '/models/party_invitation.dart';
import '/models/party_request.dart';
import '/widgets/dialogs/success_sheet.dart';

///Used for displaying all information about a notification
class NotificationSheet extends StatefulWidget {
  final Object notif;
  // Passing an object in order to check its type when receiving
  final Function(Object) onAction;
  const NotificationSheet(
    this.notif,
    this.onAction, {
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

  Widget get _content {
    if (widget.notif is FriendInvitation) return _friendInvContent();
    if (widget.notif is PartyInvitation) return _partyInvContent();
    return _partyReqContent();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 200,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              //TODO implement info about notification
              child: _content,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: widget.notif is! PartyRequest,
                      child: GestureDetector(
                        onTap: () async {
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
                          widget.onAction(widget.notif);
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
                        widget.onAction(widget.notif);
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _friendInvContent() {
    return const Wrap();
  }

  Widget _partyInvContent() {
    return const Wrap();
  }

  Widget _partyReqContent() {
    return const Wrap(
      children: [],
    );
  }
}
