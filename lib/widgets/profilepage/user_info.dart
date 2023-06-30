import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/utils/theming.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  bool showMoreDesc = false;

  @override
  Widget build(BuildContext context) {
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
                    style: TextStyle(
                      color: Theming.whiteTone,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.partiesProfile1,
                    style: TextStyle(
                      color: Theming.whiteTone.withOpacity(0.5),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Theming.whiteTone.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Text(
                    "@Jumpee",
                    style: TextStyle(
                      color: Theming.greenTone,
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () => context.push("/friend-list"),
              child: SizedBox(
                width: 100,
                child: Column(
                  children: [
                    const Text(
                      "420",
                      style: TextStyle(
                        color: Theming.whiteTone,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.friendsProfile,
                      style: TextStyle(
                        color: Theming.whiteTone.withOpacity(0.5),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
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
              onLongPress: () {
                //Show modal bottom sheet with full description
              },
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
                  AppLocalizations.of(context)!.addAFriend,
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
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  builder: (ctx) {
                    return SizedBox(
                      height: 200,
                      //Show this if user did not provide any social media
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(ctx).viewPadding.bottom,
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.emptyHere,
                            style: TextStyle(
                              color: Theming.whiteTone.withOpacity(0.7),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
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
                    width: 2,
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
