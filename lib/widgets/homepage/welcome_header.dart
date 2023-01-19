import 'package:flutter/material.dart';

import '/utils/theming.dart';

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Siema, Oliwier',
                  style: TextStyle(
                    fontSize: 32,
                    color: Theming.whiteTone,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Masz 5 powiadomień!",
                  style: TextStyle(
                    color: Theming.primaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            const CircleAvatar(
              backgroundImage: NetworkImage(
                "https://imgs.search.brave.com/Sh1KvzTzy10m30RShyompgGbNefsark8-QTMfC19svY/rs:fit:370:225:1/g:ce/aHR0cHM6Ly90c2Uz/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC54/MWpmLWJTdGJlbkFo/U0poYXdKMmNRSGFK/ZSZwaWQ9QXBp",
              ),
              backgroundColor: Colors.lightGreen,
              radius: 36,
            )
          ],
        ),
      ],
    );
  }
}
