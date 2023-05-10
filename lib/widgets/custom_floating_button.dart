import 'package:flutter/material.dart';

import '../utils/theming.dart';
import './glass_morphism.dart';

class CustomFloatingButton extends StatelessWidget {
  final String caption;
  final VoidCallback onTap;
  const CustomFloatingButton({
    required this.caption,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 14, bottom: 15),
      child: GestureDetector(
        onTap: onTap,
        child: GlassMorphism(
          blur: 10,
          opacity: 0.1,
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.linearToEaseOut,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: Text(
              caption,
              style: const TextStyle(
                color: Theming.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
