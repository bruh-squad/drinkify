import 'package:flutter/material.dart';

import '/utils/theming.dart';
import '../../models/user.dart';

class Parties extends StatelessWidget {
  final User user;
  const Parties(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Imprezy",
                style: Styles.categoryText,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Sortuj",
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
