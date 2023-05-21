import 'package:drinkify/utils/locale_support.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/utils/theming.dart';

class PartyStatus extends StatefulWidget {
  final Function(int) onSelect;
  const PartyStatus({
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
    selectedIndex = 1;
  }

  late AppLocalizations transl;

  @override
  Widget build(BuildContext context) {
    transl = LocaleSupport.appTranslates(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15 / 2),
          child: Text(
            transl.partyStatus.toUpperCase(),
            style: TextStyle(
              color: Theming.whiteTone.withOpacity(0.3),
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
                  _statusItem(1, transl.private),
                  _statusItem(2, transl.public),
                  _statusItem(3, transl.secret),
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
