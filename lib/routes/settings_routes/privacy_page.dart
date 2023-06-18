import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/utils/theming.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

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
        title: Text(
          AppLocalizations.of(context)!.privacyPolicy,
          style: const TextStyle(
            color: Theming.whiteTone,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 30,
            right: 30,
            top: 20,
          ),
          child: Text(
            "Narazie nie ma prywatnosci ¯\\_(ツ)_/¯",
            style: TextStyle(
              color: Theming.whiteTone,
            ),
          ),
        ),
      ),
    );
  }
}
