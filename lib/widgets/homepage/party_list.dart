import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/utils/theming.dart';

class PartyList extends StatelessWidget {
  const PartyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 35),
        Text(
          AppLocalizations.of(context)!.parties,
          style: Styles.categoryText,
        ),

        //Display if there are no parties
        AspectRatio(
          aspectRatio: 1 / 1,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 70, //NavBar height to make the Text look more centered
              ),
              child: SizedBox(
                child: Text(
                  AppLocalizations.of(context)!.noParties,
                  style: TextStyle(
                    color: Theming.whiteTone.withOpacity(0.7),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
