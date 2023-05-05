import 'package:flutter/material.dart';

import '/utils/theming.dart';
import '/models/user.dart';
import '/utils/locale_support.dart';

class Parties extends StatelessWidget {
  final User user;
  const Parties(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    final transl = LocaleSupport.appTranslates(context);

    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                transl.partiesProfile2,
                style: Styles.categoryText,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  transl.sort,
                  style: Styles.smallTextButton,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
