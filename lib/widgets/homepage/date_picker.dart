import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/utils/ext.dart' show Capitalize;
import '/utils/theming.dart';

int selectedMonthIndex = DateTime.now().month - 1;
int selectedYearIndex = 0;

class DatePicker extends StatefulWidget {
  final Function(int, int) onSelect;

  const DatePicker({
    required this.onSelect,
    super.key,
  });

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late int tempMonthIndex;
  late int tempYearIndex;

  late final FixedExtentScrollController monthCtrl;
  late final FixedExtentScrollController yearCtrl;

  @override
  void initState() {
    super.initState();
    tempMonthIndex = selectedMonthIndex;
    tempYearIndex = selectedYearIndex;
    monthCtrl = FixedExtentScrollController(
      initialItem: selectedMonthIndex,
    );
    yearCtrl = FixedExtentScrollController(
      initialItem: selectedYearIndex,
    );

    initializeDateFormatting();
  }

  @override
  void dispose() {
    super.dispose();
    monthCtrl.dispose();
    yearCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SafeArea(
        child: Wrap(
          children: [
            //Button
            GestureDetector(
              onTap: () {
                widget.onSelect(
                  yearCtrl.selectedItem,
                  monthCtrl.selectedItem + 1,
                );
                selectedMonthIndex = tempMonthIndex;
                selectedYearIndex = tempYearIndex;
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                decoration: const BoxDecoration(
                  color: Theming.primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context)!.select,
                  style: const TextStyle(
                    color: Theming.bgColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            //Month wheel
            SizedBox(
              height: 100,
              width: double.infinity,
              child: RotatedBox(
                quarterTurns: -1,
                child: ListWheelScrollView(
                  controller: monthCtrl,
                  itemExtent: 160,
                  physics: const FixedExtentScrollPhysics(),
                  perspective: 0.00000001,
                  onSelectedItemChanged: (value) {
                    setState(() => tempMonthIndex = value);
                  },
                  children: [
                    for (int i = 0; i < 12; i++)
                      _datePickerItem(
                        i,
                        type: "MONTH",
                      ),
                  ],
                ),
              ),
            ),

            //Year wheel
            SizedBox(
              height: 100,
              width: double.infinity,
              child: RotatedBox(
                quarterTurns: -1,
                child: ListWheelScrollView(
                  controller: yearCtrl,
                  itemExtent: 160,
                  physics: const FixedExtentScrollPhysics(),
                  perspective: 0.00000001,
                  onSelectedItemChanged: (value) {
                    setState(() => tempYearIndex = value);
                  },
                  children: [
                    for (int i = 0; i < 15; i++)
                      _datePickerItem(
                        i,
                        type: "YEAR",
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _datePickerItem(int value, {String type = ""}) {
    bool isMonth = type == "MONTH";
    bool isMonthSelected = tempMonthIndex == value;
    bool isYearSelected = tempYearIndex == value;

    return Center(
      child: RotatedBox(
        quarterTurns: 1,
        child: Text(
          isMonth
              ? DateFormat("MMMM", AppLocalizations.of(context)!.localeName)
                  .format(
                    DateTime(
                      DateTime.now().year,
                      value + 1,
                    ),
                  )
                  .capitalize()
              : DateFormat("yyyy").format(
                  DateTime(
                    value + DateTime.now().year,
                  ),
                ),
          style: isMonth
              ? isMonthSelected
                  ? Styles.dateTextSelected
                  : Styles.dateTextUnselected
              : isYearSelected
                  ? Styles.dateTextSelected
                  : Styles.dateTextUnselected,
        ),
      ),
    );
  }
}
