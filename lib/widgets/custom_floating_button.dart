import 'package:flutter/material.dart';

class CustomFloatingButton extends StatelessWidget {
  final Text caption;
  final Color backgroundColor;
  final VoidCallback onTap;
  final Color shadowColor;
  const CustomFloatingButton({
    required this.caption,
    required this.backgroundColor,
    required this.onTap,
    required this.shadowColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 14, bottom: 25),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.linearToEaseOut,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                blurRadius: 10,
                spreadRadius: 1,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: caption,
        ),
      ),
    );
  }
}
