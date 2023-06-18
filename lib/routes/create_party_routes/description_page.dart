import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/utils/theming.dart';
import '/utils/ext.dart';

class DescriptionPage extends StatelessWidget {
  final TextEditingController controller;
  const DescriptionPage({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theming.bgColor,
      appBar: AppBar(
        backgroundColor: Theming.bgColor,
        surfaceTintColor: Theming.bgColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            splashColor: Colors.transparent,
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Theming.whiteTone,
            ),
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.description.capitalize(),
          style: const TextStyle(
            color: Theming.whiteTone,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 30,
          right: 30,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(right: 5),
                decoration: BoxDecoration(
                  color: Theming.whiteTone.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    width: 1.5,
                    color: Theming.primaryColor,
                  ),
                ),
                child: TextField(
                  controller: controller,
                  maxLines: null,
                  cursorColor: Theming.primaryColor,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.description_outlined,
                      color: Theming.primaryColor,
                    ),
                    hintText: AppLocalizations.of(context)!.addPartyDescription,
                    hintStyle: TextStyle(
                      color: Theming.whiteTone.withOpacity(0.3),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
