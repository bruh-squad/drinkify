import 'package:flutter/material.dart';

import '/utils/theming.dart';

class PartyList extends StatelessWidget {
  const PartyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width - 30 * 2,
        ),
        const Text(
          "Imprezy",
          style: Styles.categoryText,
        ),
        const SizedBox(height: 100),
        Align(
          alignment: Alignment.center,
          child: Text(
            "Brak imprez",
            style: Styles.emptyListText,
          ),
        ),
      ],
    );
  }
}
