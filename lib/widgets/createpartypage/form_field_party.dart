import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/utils/theming.dart';

class FormFieldParty extends StatefulWidget {
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

  @override
  State<FormFieldParty> createState() => _FormFieldPartyState();
}

class _FormFieldPartyState extends State<FormFieldParty> {
  late final TextEditingController ctrl;

  bool get _isSelected => widget.index == widget.selectedFieldIndex;

  bool get _notFilled => widget.errorFields.contains(widget.index);

  @override
  void initState() {
    super.initState();
    ctrl = TextEditingController(text: widget.value);
  }

  @override
  void dispose() {
    super.dispose();
    ctrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15 / 2),
          child: Text(
            widget.caption.toUpperCase(),
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
            borderRadius: widget.borderRadius,
            border: Border.all(
              width: 1.5,
              color: _notFilled
                  ? Theming.errorColor
                  : _isSelected ||
                          widget.value != null && widget.value!.isNotEmpty
                      ? Theming.primaryColor
                      : Theming.whiteTone.withOpacity(0.2),
            ),
          ),
          child: TextField(
            controller: ctrl,
            enabled: widget.enabled,
            cursorColor: Theming.primaryColor,
            onTap: () => widget.onSelect(widget.index),
            onChanged: (val) {
              if (widget.onType == null) return;
              widget.onType!(val);
            },
            decoration: InputDecoration(
              hintText: !widget.enabled &&
                      widget.value != null &&
                      widget.value!.isNotEmpty
                  ? widget.value
                  : widget.placeholder,
              hintStyle: TextStyle(
                color: Theming.whiteTone.withOpacity(
                  !widget.enabled &&
                          widget.value != null &&
                          widget.value!.isNotEmpty
                      ? 1
                      : 0.3,
                ),
              ),
              prefixIcon: Icon(
                widget.prefixIcon,
                color: _notFilled
                    ? Theming.errorColor
                    : _isSelected ||
                            widget.value != null && widget.value!.isNotEmpty
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
              color: widget.errorFields.contains(widget.index)
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
