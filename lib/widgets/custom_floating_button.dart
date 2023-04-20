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
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 55 + MediaQuery.of(context).viewPadding.bottom,
          width: double.infinity,
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
          ),
          child: child,
        ),
      ),
    );
  }
}
