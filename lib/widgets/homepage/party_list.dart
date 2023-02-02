import 'package:flutter/material.dart';

import '/utils/theming.dart';

class PartyList extends StatelessWidget {
  const PartyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 35,
        ),
        const Text(
          "Imprezy",
          style: Styles.categoryText,
        ),
        const SizedBox(height: 100),
        Center(
          child: Text(
            "Brak imprez",
            style: Styles.emptyListText,
          ),
        ),
      ],
    );
  }
}
