import 'package:flutter/material.dart';

import '/utils/theming.dart';

class PartyDesc extends StatelessWidget {
  final String description;
  const PartyDesc({
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 110 - 100,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(0),
        children: [
          const SizedBox(height: 145),
          Text(
            description,
            style: const TextStyle(color: Theming.whiteTone),
          ),
          const SizedBox(height: 120),
        ],
      ),
    );
  }
}
