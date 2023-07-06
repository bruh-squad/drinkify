import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/utils/theming.dart';

class FormFieldParty extends StatelessWidget {
  final int index;
  final int? selectedFieldIndex;
  final String caption;
  final String placeholder;
  final IconData prefixIcon;
  final String? value;
  final List<int> errorFields;
  final bool enabled;
  final BorderRadius borderRadius;
  final void Function(String)? onType;
  final void Function(int) onSelect;
  const FormFieldParty({
    required this.index,
    required this.selectedFieldIndex,
    required this.caption,
    required this.placeholder,
    required this.prefixIcon,
    this.value,
    this.onType,
    required this.onSelect,
    this.enabled = true,
    required this.errorFields,
    this.borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(15),
      topRight: Radius.circular(15),
      bottomLeft: Radius.circular(15),
      bottomRight: Radius.circular(15),
    ),
    super.key,
  });

  bool get _isSelected => index == selectedFieldIndex;

  bool get _notFilled => errorFields.contains(index);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15 / 2),
          child: Text(
            caption.toUpperCase(),
            style: TextStyle(
              color: _notFilled
                  ? Theming.errorColor
                  : _isSelected
                      ? Theming.primaryColor
                      : Theming.whiteTone.withOpacity(0.5),
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        AnimatedContainer(
          height: 50,
          width: double.infinity,
          duration: const Duration(milliseconds: 300),
          curve: Curves.linearToEaseOut,
          padding: const EdgeInsets.only(right: 7.5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theming.whiteTone.withOpacity(0.1),
            borderRadius: borderRadius,
            border: Border.all(
              width: 1.5,
              color: _notFilled
                  ? Theming.errorColor
                  : _isSelected || value != null && value!.isNotEmpty
                      ? Theming.primaryColor
                      : Theming.whiteTone.withOpacity(0.2),
            ),
          ),
          child: TextField(
            enabled: enabled,
            cursorColor: Theming.primaryColor,
            onTap: () => onSelect(index),
            onChanged: (val) {
              if (onType == null) return;
              onType!(val);
            },
            decoration: InputDecoration(
              hintText: !enabled && value != null && value!.isNotEmpty
                  ? value
                  : placeholder,
              hintStyle: TextStyle(
                color: Theming.whiteTone.withOpacity(
                  !enabled && value != null && value!.isNotEmpty ? 1 : 0.3,
                ),
              ),
              prefixIcon: Icon(
                prefixIcon,
                color: _notFilled
                    ? Theming.errorColor
                    : _isSelected || value != null && value!.isNotEmpty
                        ? Theming.primaryColor
                        : Theming.whiteTone.withOpacity(0.25),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 7.5,
            top: 2,
          ),
          child: Text(
            "• ${AppLocalizations.of(context)!.requiredField}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10,
              color: errorFields.contains(index)
                  ? Theming.errorColor
                  : Colors.transparent,
            ),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
