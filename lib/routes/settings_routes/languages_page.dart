import 'package:drinkify/widgets/glass_morphism.dart';
import 'package:flutter/material.dart';

import '/utils/theming.dart';

class LanguagesPage extends StatelessWidget {
  const LanguagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theming.bgColor,
      body: Padding(
        padding: EdgeInsets.only(
          left: 30,
          right: 30,
          top: MediaQuery.of(context).padding.top + 20,
        ),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 16 / 6,
          children: [
            _languageField(
              imagePath: "assets/images/pl.jpg",
              caption: "Polski",
            ),
            _languageField(
              imagePath: "assets/images/uk.jpg",
              caption: "English",
            ),
          ],
        ),
      ),
    );
  }

  Widget _languageField({
    required String imagePath,
    required String caption,
  }) {
    return GlassMorphism(
      blur: 20,
      opacity: 0.2,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          // color: Theming.primaryColor,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                imagePath,
                scale: 4,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              caption,
              style: const TextStyle(
                color: Theming.whiteTone,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
