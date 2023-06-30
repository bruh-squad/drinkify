import 'package:flutter/material.dart';

import '../utils/theming.dart';

typedef Index = int;

///Custom widget as a replacement for [TextField]
class EditField extends StatelessWidget {
  final int index;
  final int? selectedFieldIndex;
  final List<int> errorFields;
  final String caption;
  final IconData icon;
  final String placeholder;
  final TextEditingController? ctrl;
  final bool isDateSelected;
  final bool isDate;
  final bool isPassword;
  final TextInputType? keyboardType;
  final void Function(Index) onSelect;

  const EditField({
    required this.index,
    this.selectedFieldIndex,
    required this.caption,
    required this.icon,
    required this.placeholder,
    this.ctrl,
    this.isDateSelected = false,
    this.isDate = false,
    this.isPassword = false,
    this.keyboardType,
    required this.onSelect,
    this.errorFields = const [],
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
            width: double.infinity,
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.only(right: 10),
            alignment: Alignment.center,
            duration: const Duration(milliseconds: 500),
            curve: Curves.linearToEaseOut,
            decoration: BoxDecoration(
              color: Theming.bgColor,
              border: Border.all(
                width: 1.5,
                color: errorFields.contains(index)
                    ? Theming.errorColor
                    : index == selectedFieldIndex
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
              cursorColor: isDate ? Theming.bgColor : Theming.primaryColor,
              selectionControls: _TextSelectionHandleTheme(),
              readOnly: isDate,
              controller: ctrl,
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: TextStyle(
                  fontSize: 14,
                  letterSpacing: 0,
                  color: errorFields.contains(index) && selectedFieldIndex == index
                      ? Theming.errorColor
                      : index == selectedFieldIndex
                          ? Theming.whiteTone.withOpacity(_borderOpacity + 0.2)
                          : Colors.transparent,
                ),
                prefixIcon: Icon(
                  icon,
                  color: errorFields.contains(index)
                      ? Theming.errorColor
                      : index == selectedFieldIndex
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
              top: index == selectedFieldIndex ||
                      (ctrl != null && ctrl!.text.isNotEmpty) ||
                      isDateSelected
                  ? 0
                  : 30,
              left: _iconSize * 2,
              bottom: index == selectedFieldIndex ||
                      (ctrl != null && ctrl!.text.isNotEmpty) ||
                      isDateSelected
                  ? 0
                  : 10,
            ),
            duration: const Duration(milliseconds: 500),
            curve: Curves.linearToEaseOut,
            child: Container(
              color: Theming.bgColor,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                caption,
                style: TextStyle(
                  color: errorFields.contains(index)
                      ? Theming.errorColor
                      : index == selectedFieldIndex
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

class _TextSelectionHandleTheme extends TextSelectionControls {
  @override
  Widget buildHandle(
    BuildContext context,
    TextSelectionHandleType type,
    double textLineHeight, [
    VoidCallback? onTap,
  ]) {
    return const SizedBox.shrink();
  }

  @override
  Widget buildToolbar(
    BuildContext context,
    Rect globalEditableRegion,
    double textLineHeight,
    Offset selectionMidpoint,
    List<TextSelectionPoint> endpoints,
    TextSelectionDelegate delegate,
    ClipboardStatusNotifier? clipboardStatus,
    Offset? lastSecondaryTapDownPosition,
  ) {
    return const SizedBox.shrink();
  }

  @override
  Offset getHandleAnchor(TextSelectionHandleType type, double textLineHeight) {
    return Offset.zero;
  }

  @override
  Size getHandleSize(double textLineHeight) => Size.zero;
}
