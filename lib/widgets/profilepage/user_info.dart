import 'package:flutter/material.dart';

import '/utils/theming.dart';
import '/models/user_model.dart';

class UserInfo extends StatelessWidget {
  final User user;
  const UserInfo(this.user, {super.key});

  //TODO: replace values with user parameters

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Profile picture
        const CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(
            "https://imgs.search.brave.com/Sh1KvzTzy10m30RShyompgGbNefsark8-QTMfC19svY/rs:fit:370:225:1/g:ce/aHR0cHM6Ly90c2Uz/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC54/MWpmLWJTdGJlbkFo/U0poYXdKMmNRSGFK/ZSZwaWQ9QXBp",
          ),
          backgroundColor: Theming.bgColorLight,
        ),
        const SizedBox(height: 10),
        //Username
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
          decoration: BoxDecoration(
            color: Theming.whiteTone.withOpacity(0.2),
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Text(
            "@Jumpee",
            style: TextStyle(
              color: Color(0xFFAEFF00),
            ),
          ),
        ),

        const SizedBox(height: 20),

        //Parties attended / Friends
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                const Text("10", style: Styles.userInfoStatistic),
                Text("Imprez", style: Styles.userInfoType),
              ],
            ),
            Column(
              children: [
                const Text("420", style: Styles.userInfoStatistic),
                Text("Znajomych", style: Styles.userInfoType),
              ],
            ),
          ],
        ),

        const SizedBox(height: 10),

        //Add friend / Social media link
        Row(
          children: [
            //Add friend
            GestureDetector(
              onTap: () {
                //sending a friend request
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width - 30 * 2 - 50 - 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theming.bgColorLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Dodaj znajomego",
                  style: Styles.buttonTextLight,
                ),
              ),
            ),

            const Spacer(),

            //Social media link
            GestureDetector(
              onTap: () {
                //Show modal bottom sheet and display all provided social media links
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Theming.whiteTone.withOpacity(0.2),
                  ),
                ),
                child: const Icon(
                  Icons.camera,
                  color: Theming.whiteTone,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
