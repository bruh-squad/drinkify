import 'package:flutter/material.dart';

class CustomFloatingButton extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final VoidCallback onTap;
  const CustomFloatingButton({
    required this.child,
    required this.backgroundColor,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ///To make this button work add [FloatingActionButtonLocation.centerDocked] your Scaffold
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 55 + MediaQuery.of(context).padding.bottom,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: SafeArea(child: child),
        ),
      ),
    );
  }
}
