import 'package:drinkify/widgets/custom_floating_button.dart';
import 'package:flutter/material.dart';

import '/utils/theming.dart';
import '/utils/locale_support.dart';
import '/utils/ext.dart';

class DescriptionPage extends StatelessWidget {
  final TextEditingController controller;
  const DescriptionPage({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final transl = LocaleSupport.appTranslates(context);

    return Scaffold(
      backgroundColor: Theming.bgColor,
      floatingActionButton: CustomFloatingButton(
        caption: transl.clearDescription,
        onTap: () => controller.clear(),
      ),
      appBar: AppBar(
        backgroundColor: Theming.bgColor,
        surfaceTintColor: Theming.bgColor,
        leading: IconButton(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theming.whiteTone,
            size: 24,
          ),
        ),
        title: Text(
          transl.description.capitalize(),
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
                    hintText: transl.addPartyDescription,
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
