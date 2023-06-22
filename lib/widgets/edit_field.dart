import 'package:flutter/material.dart';

import '../utils/theming.dart';

typedef Index = int;

///Custom widget as a replacemet for [TextField]
class EditField extends StatelessWidget {
  final int index;
  final int? selectedFieldIndex;
  final String caption;
  final IconData icon;
  final String placeholder;
  final TextEditingController ctrl;
  final bool isPassword;
  final TextInputType? keyboardType;
  final bool manyInRow;
  final void Function(Index) onSelect;

  const EditField({
    required this.index,
    this.selectedFieldIndex,
    required this.caption,
    required this.icon,
    required this.placeholder,
    required this.ctrl,
    this.isPassword = false,
    this.keyboardType,
    required this.onSelect,
    this.manyInRow = false,
    super.key,
  });

  double get _radius => 10;

  double get _iconSize => 24;

  double get _borderOpacity => 0.3;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Stack(
        children: [
          AnimatedContainer(
            height: 60,
            width: manyInRow
                ? MediaQuery.of(context).size.width / 2 - 30 - 10
                : double.infinity,
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.only(right: 10),
            alignment: Alignment.center,
            duration: const Duration(milliseconds: 500),
            curve: Curves.linearToEaseOut,
            decoration: BoxDecoration(
              color: Theming.bgColor,
              border: Border.all(
                width: 1.5,
                color: index == selectedFieldIndex
                    ? Theming.primaryColor
                    : Theming.whiteTone.withOpacity(_borderOpacity),
              ),
              borderRadius: BorderRadius.circular(_radius),
            ),
            child: TextField(
              onTap: () => onSelect(index),
              obscureText: isPassword,
              keyboardType: keyboardType,
              style: TextStyle(
                color: Theming.whiteTone,
                letterSpacing: isPassword ? 4 : 0,
              ),
              cursorColor: Theming.primaryColor,
              controller: ctrl,
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: TextStyle(
                  fontSize: 14,
                  letterSpacing: 0,
                  color: index == selectedFieldIndex
                      ? Theming.whiteTone.withOpacity(_borderOpacity + 0.2)
                      : Colors.transparent,
                ),
                prefixIcon: Icon(
                  icon,
                  color: index == selectedFieldIndex
                      ? Theming.primaryColor
                      : Theming.whiteTone.withOpacity(_borderOpacity),
                  size: _iconSize,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          AnimatedPadding(
            padding: EdgeInsets.only(
              top: index == selectedFieldIndex || ctrl.text.isNotEmpty ? 0 : 30,
              left: _iconSize * 2,
              bottom:
                  index == selectedFieldIndex || ctrl.text.isNotEmpty ? 0 : 10,
            ),
            duration: const Duration(milliseconds: 500),
            curve: Curves.linearToEaseOut,
            child: Container(
              color: Theming.bgColor,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                caption,
                style: TextStyle(
                  color: index == selectedFieldIndex
                      ? Theming.primaryColor
                      : Theming.whiteTone.withOpacity(_borderOpacity + 0.1),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
