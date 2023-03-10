import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '/utils/ext.dart' show Capitalize;

import '/utils/theming.dart';

class DatePicker extends StatefulWidget {
  final int monthIndex;
  final int yearIndex;
  final Function(int, int) onSelect;
  const DatePicker({
    required this.monthIndex,
    required this.yearIndex,
    required this.onSelect,
    super.key,
  });

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late int selectedMonthIndex;
  late int selectedYearIndex;

  @override
  void initState() {
    super.initState();
    selectedMonthIndex = widget.monthIndex;
    selectedYearIndex = widget.yearIndex;

    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    var monthCtrl = FixedExtentScrollController(
      initialItem: selectedMonthIndex,
    );
    var yearCtrl = FixedExtentScrollController(
      initialItem: 0,
    );

    return SizedBox(
      height: 200 + 8 * 2 + 20 + 40 + MediaQuery.of(context).padding.bottom,
      child: Column(
        children: [
          //Button
          GestureDetector(
            onTap: () {
              widget.onSelect(
                yearCtrl.selectedItem,
                monthCtrl.selectedItem + 1,
              );
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
              ? DateFormat("MMMM", "pl")
                  .format(
                    DateTime(
                      DateTime.now().year,
                      value + 1,
                    ),
                  )
                  .capitalize()
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
