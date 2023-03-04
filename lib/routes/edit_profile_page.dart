import 'package:flutter/material.dart';

import '../widgets/custom_floating_button.dart';

import '../utils/theming.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theming.bgColor,
      floatingActionButton: CustomFloatingButton(
        caption: const Text(
          "Zapisz",
          style: TextStyle(
            color: Theming.whiteTone,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Theming.primaryColor,
        shadowColor: Colors.black.withOpacity(0.3),
        onTap: () {},
      ),
      body: Column(
        children: const [],
      ),
    );
  }
}
