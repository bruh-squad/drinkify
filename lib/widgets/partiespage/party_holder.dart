import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

import '/models/party.dart';

import '/utils/locale_support.dart';
import '/utils/theming.dart';

class PartyHolder extends StatelessWidget {
  final Party party;
  const PartyHolder({required this.party, super.key});

  @override
  Widget build(BuildContext context) {
    const double imageAspectRatio = 16 / 6;

    var transl = LocaleSupport.appTranslates(context);

    return GestureDetector(
      onTap: () => context.push(
        '/party',
        extra: party,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Party title
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              party.name,
              style: const TextStyle(
                color: Theming.whiteTone,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),

          //Bottom info + Image/Color
          Container(
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              color: Theming.whiteTone.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 10),
                  blurRadius: 10,
                  color: const Color.fromARGB(
                    255,
                    0,
                    0,
                    0,
                  ).withOpacity(0.2),
                ),
              ],
            ),
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: imageAspectRatio,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          "https://getwallpapers.com/wallpaper/full/b/6/f/101128.jpg",
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 9,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Date
                      Row(
                        children: [
                          const Icon(
                            Icons.date_range_outlined,
                            color: Theming.primaryColor,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            DateFormat.yMd(transl.localeName).format(party.startTime),
                            style: Styles.partyHeaderInfo,
                          ),
                        ],
                      ),

                      //Time
                      Row(
                        children: [
                          const Icon(
                            Icons.timelapse,
                            color: Theming.primaryColor,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            DateFormat.Hm(transl.localeName).format(party.startTime),
                            style: Styles.partyHeaderInfo,
                          ),
                        ],
                      ),

                      //Number of people
                      Row(
                        children: [
                          const Icon(
                            Icons.group_outlined,
                            color: Theming.primaryColor,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "${party.participants?.length}",
                            style: Styles.partyHeaderInfo,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //Bottom Margin
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
