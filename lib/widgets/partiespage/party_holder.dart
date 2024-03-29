import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/models/party.dart';

import '/utils/theming.dart';

class PartyHolder extends StatelessWidget {
  final Party party;
  final VoidCallback onTap;
  const PartyHolder(
    this.party,
    this.onTap, {
    super.key,
  });

  double get _imageAspectRatio => 16 / 6;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                  aspectRatio: _imageAspectRatio,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          party.image!,
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
                            DateFormat.yMd(
                              AppLocalizations.of(context)!.localeName,
                            ).format(party.startTime),
                            style: const TextStyle(
                              color: Theming.whiteTone,
                              fontWeight: FontWeight.bold,
                            ),
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
                            DateFormat.Hm(
                              AppLocalizations.of(context)!.localeName,
                            ).format(party.startTime),
                            style: const TextStyle(
                              color: Theming.whiteTone,
                              fontWeight: FontWeight.bold,
                            ),
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
                            "${party.participants!.length}",
                            style: const TextStyle(
                              color: Theming.whiteTone,
                              fontWeight: FontWeight.bold,
                            ),
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
