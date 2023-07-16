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
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Stack(
          children: [
            const Column(
              children: [
                //TODO implement info avbout notification
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                color: Theming.bgColor,
                boxShadow: [
                  BoxShadow(
                    color: Theming.bgColor,
                    offset: Offset(0, -15),
                    spreadRadius: 15,
                    blurRadius: 15,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2 - 60,
                      decoration: BoxDecoration(
                        color: Theming.greenTone.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.rejectNotif,
                        style: const TextStyle(
                          color: Theming.greenTone,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2 - 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Theming.errorColor.withOpacity(0.2),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.rejectNotif,
                        style: const TextStyle(
                          color: Theming.errorColor,
                          fontWeight: FontWeight.bold,
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
    );
  }
}
