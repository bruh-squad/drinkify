import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/utils/theming.dart';

class OrganizationPage extends StatelessWidget {
  const OrganizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theming.bgColor,
      appBar: AppBar(
        backgroundColor: Theming.bgColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Theming.whiteTone,
            ),
          ),
        ),
        title: const Text(
          "Twoje imprezy",
          style: TextStyle(
            color: Theming.whiteTone,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
    );
  }

  Widget _partyItem() {
    return Container();
  }
}
