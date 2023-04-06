import 'package:flutter/material.dart';

import '/utils/locale_support.dart';
import '/utils/theming.dart';

class PartyList extends StatelessWidget {
  const PartyList({super.key});

  @override
  Widget build(BuildContext context) {
    final transl = LocaleSupport.appTranslates(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 35),
        Text(
          transl.parties,
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
                  transl.noParties,
                  style: Styles.emptyListText,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
