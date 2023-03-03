import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '/utils/ext.dart' show Capitalize;

import '/utils/theming.dart';

// ignore: must_be_immutable
class DatePicker extends StatelessWidget {
  int selectedMonthIndex;
  int selectedYearIndex;
  Function(int, int) onSelect;
  DatePicker({
    required this.selectedMonthIndex,
    required this.selectedYearIndex,
    required this.onSelect,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var monthCtrl = FixedExtentScrollController(
      initialItem: selectedMonthIndex,
    );
    var yearCtrl = FixedExtentScrollController(
      initialItem: 0,
    );

    initializeDateFormatting();

    return StatefulBuilder(
      builder: (context, setState) => SizedBox(
        height: 200 + 20 + 10 * 2 + 60 + MediaQuery.of(context).padding.bottom,
        child: Column(
          children: [
            //Button
            GestureDetector(
              onTap: () {
                onSelect(yearCtrl.selectedItem, monthCtrl.selectedItem + 1);
              },
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Theming.primaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  "Wybierz",
                  style: TextStyle(
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
                    setState(() {
                      selectedMonthIndex = value;
                    });
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
                    setState(() {
                      selectedYearIndex = value + DateTime.now().year;
                    });
                  },
                  children: [
                    for (int i = DateTime.now().year;
                        i < DateTime.now().year + 15;
                        i++)
                      _datePickerItem(i, type: "YEAR"),
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
    bool isMonthSelected = selectedMonthIndex == value;
    bool isYearSelected = selectedYearIndex == value;

    return Center(
      child: RotatedBox(
        quarterTurns: 1,
        child: Text(
          type == "MONTH"
              ? DateFormat("MMMM", "pl").format(
                  DateTime(
                    DateTime.now().year,
                    value + 1,
                  ),
                ).capitalize()
              : DateFormat("yyyy").format(
                  DateTime(
                    value,
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
