import 'package:flutter/material.dart';

import '/utils/theming.dart';
import '/models/user.dart';
import '/utils/locale_support.dart';

class UserInfo extends StatefulWidget {
  final User user;
  const UserInfo(this.user, {super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  //TODO: replace values with user parameters
  bool showMoreDesc = false;

  @override
  Widget build(BuildContext context) {
    final transl = LocaleSupport.appTranslates(context);
    return Column(
      children: [
        //Parties attended / Profile pic with username / Friends
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 100,
              child: Column(
                children: [
                  const Text(
                    "10",
                    style: Styles.userInfoStatistic,
                  ),
                  Text(
                    transl.partiesProfile1,
                    style: Styles.userInfoType,
                  ),
                ],
              ),
            ),

            //Profile picture
            Column(
              children: [
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
              ],
            ),
            SizedBox(
              width: 100,
              child: Column(
                children: [
                  const Text(
                    "420",
                    style: Styles.userInfoStatistic,
                  ),
                  Text(
                    transl.friendsProfile,
                    style: Styles.userInfoType,
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        //Bio
        GestureDetector(
          onTap: () {
            setState(() => showMoreDesc = !showMoreDesc);
          },
          child: Text(
            "Współczesny artysta estradowy, showman, erudyta, omnibus, polihistor, geniusz, muzyk, artysta, filantrop, wizjoner, komentator e-sportowy, osoba nieszablonowa, posiadacz nadzwyczajnie dużego ilorazu inteligencji oraz człowiek sukcesu który przeszedł grę zwaną życiem.",
            style: const TextStyle(color: Theming.whiteTone),
            overflow: TextOverflow.ellipsis,
            maxLines: showMoreDesc ? 10 : 2,
          ),
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
                  color: Theming.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  transl.addAFriend,
                  style: Styles.buttonTextLight,
                ),
              ),
            ),

            const Spacer(),

            //Social media link
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Theming.bgColor,
                  useRootNavigator: true,
                  enableDrag: false,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  builder: (context) {
                    return SizedBox(
                      height: 200,
                      //Show this if user did not provide any social media
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewPadding.bottom,
                          ),
                          child: Text(
                            transl.emptyHere,
                            style: Styles.emptyListText,
                          ),
                        ),
                      ),
                    );
                  },
                );
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
                  Icons.south_america,
                  color: Theming.whiteTone,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
