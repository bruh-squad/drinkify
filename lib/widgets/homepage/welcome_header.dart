import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/utils/theming.dart';
import '/models/user.dart';

class WelcomeHeader extends StatelessWidget {
  final User user;
  const WelcomeHeader(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => context.push("/notifications"),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${AppLocalizations.of(context)!.welcomeHeader}${user.firstName ?? "..."}',
                    style: const TextStyle(
                      fontSize: 28,
                      color: Theming.whiteTone,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${AppLocalizations.of(context)!.youHave} 5 ${AppLocalizations.of(context)!.notifications}",
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
              child: user.pfp != null
                  ? CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(user.pfp!),
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
    );
  }
}
