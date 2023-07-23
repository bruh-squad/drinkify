import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/utils/theming.dart';

class PartyStatus extends StatefulWidget {
  final int? initialValue;
  final Function(int) onSelect;

  const PartyStatus({
    this.initialValue,
    required this.onSelect,
    super.key,
  });

  @override
  State<PartyStatus> createState() => _PartyStatusState();
}

class _PartyStatusState extends State<PartyStatus> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialValue ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15 / 2),
          child: Text(
            AppLocalizations.of(context)!.partyStatus.toUpperCase(),
            style: TextStyle(
              color: Theming.whiteTone.withOpacity(0.5),
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width - 60,
          padding: const EdgeInsets.all(3),
          margin: const EdgeInsets.only(bottom: 30),
          decoration: BoxDecoration(
            color: Theming.whiteTone.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 1.5,
              color: Theming.whiteTone.withOpacity(0.2),
            ),
          ),
          child: Stack(
            children: [
              AnimatedContainer(
                width: (MediaQuery.of(context).size.width - 60) / 3 - 6,
                duration: const Duration(milliseconds: 300),
                curve: Curves.linearToEaseOut,
                margin: EdgeInsets.only(
                  left: (selectedIndex - 1) *
                      ((MediaQuery.of(context).size.width - 60) / 3),
                ),
                decoration: BoxDecoration(
                  color: Theming.primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _statusItem(1, AppLocalizations.of(context)!.private),
                  _statusItem(2, AppLocalizations.of(context)!.public),
                  _statusItem(3, AppLocalizations.of(context)!.secret),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  ///[index] must always start at 1
  Widget _statusItem(int index, String caption) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (isSelected) return;
        setState(() => selectedIndex = index);
        widget.onSelect(index);
      },
      child: SizedBox(
        width: (MediaQuery.of(context).size.width - 60) / 3 - 6,
        child: Center(
          child: Text(
            caption,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected
                  ? Theming.whiteTone
                  : Theming.whiteTone.withOpacity(0.6),
            ),
          ),
        ),
      ),
    );
  }
}
