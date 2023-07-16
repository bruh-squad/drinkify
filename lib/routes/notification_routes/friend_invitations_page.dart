import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/models/friend_invitiation.dart';
import '/utils/theming.dart';
import '/widgets/dialogs/notification_sheet.dart';

class FriendInvitationsPage extends StatelessWidget {
  final List<FriendInvitation> notif;
  const FriendInvitationsPage(
    this.notif, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return notif.isNotEmpty
        ? Column(
            children: [
              for (final fi in notif) _notifItem(fi, context),
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

  Widget _notifItem(FriendInvitation inv, BuildContext ctx) {
    final timeOfCreation =
        "${inv.createdAt!.year}-${inv.createdAt!.month}-${inv.createdAt!.day} ${inv.createdAt!.hour}:${inv.createdAt!.minute}:${inv.createdAt!.second}";

    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: ctx,
          backgroundColor: Theming.bgColor,
          isScrollControlled: true,
          builder: (_) => NotificationSheet(inv),
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
                  backgroundImage: NetworkImage(inv.sender!.pfp!),
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
                        text: " @${inv.sender!.username}",
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
