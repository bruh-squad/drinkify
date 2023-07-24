import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/models/party_invitation.dart';
import '/utils/theming.dart';
import '/widgets/dialogs/notification_sheet.dart';

class PartyInvitationsPage extends StatelessWidget {
  final List<PartyInvitation> notif;
  final VoidCallback onAction;
  const PartyInvitationsPage(
    this.notif,
    this.onAction, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return notif.isNotEmpty
        ? Column(
            children: [
              for (final pi in notif) _notifItem(pi, context),
            ],
          )
        : Center(
            child: Text(
              AppLocalizations.of(context)!.emptyHere,
              style: TextStyle(
                color: Theming.whiteTone.withOpacity(0.7),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }

  Widget _notifItem(PartyInvitation inv, BuildContext ctx) {
    final timeOfCreation =
        "${inv.createdAt!.year}-${inv.createdAt!.month}-${inv.createdAt!.day} ${inv.createdAt!.hour}:${inv.createdAt!.minute}:${inv.createdAt!.second}";

    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: ctx,
          backgroundColor: Theming.bgColor,
          isScrollControlled: true,
          builder: (_) => NotificationSheet(
            inv,
            false,
            (obj) {
              if (obj is! PartyInvitation) return;
              onAction();
            },
          ),
        );
      },
      splashColor: Theming.whiteTone.withOpacity(0.05),
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theming.whiteTone.withOpacity(0.05),
              width: 1,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 30,
        ),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Theming.bgColorLight,
                  backgroundImage: NetworkImage(inv.party!.image!),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        color: Theming.primaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theming.bgColor,
                          width: 3,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(ctx)!.notificationFrom,
                        style: const TextStyle(
                          color: Theming.whiteTone,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: " @${inv.party!.name}",
                        style: const TextStyle(
                          color: Theming.greenTone,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  timeOfCreation,
                  style: TextStyle(
                    color: Theming.whiteTone.withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
