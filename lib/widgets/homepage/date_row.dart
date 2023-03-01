import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '/utils/ext.dart' show Capitalize;
import '/utils/theming.dart';

class DateRow extends StatefulWidget {
  final EdgeInsets textPadding;
  const DateRow({required this.textPadding, super.key});

  @override
  State<DateRow> createState() => _DateRowState();
}

class _DateRowState extends State<DateRow> {
  late int selectedDayIndex;
  late int numOfDaysInMonth;
  late int selectedMonthIndex;

  @override
  void initState() {
    super.initState();
    selectedDayIndex = DateTime.now().day;
    selectedMonthIndex = DateTime.now().month;
    numOfDaysInMonth = DateTime(
      DateTime.now().year,
      DateTime.now().month + 1,
      0,
    ).day;
    initializeDateFormatting();
  }

  Map<String, Object> get currentMonthAndYear {
    return {
      "month": DateFormat("MMMM", "pl")
          .format(DateTime.now())
          .toString()
          .capitalize(),
      "year": DateTime.now().year,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 50),
        Padding(
          padding: widget.textPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${currentMonthAndYear["month"]} ${currentMonthAndYear["year"]}",
                style: Styles.categoryText,
              ),
              TextButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Theming.bgColor,
                    useRootNavigator: true,
                    enableDrag: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    builder: (context) {
                      var monthCtrl = FixedExtentScrollController(
                        initialItem: selectedMonthIndex,
                      );

                      return StatefulBuilder(
                        builder: (context, setState) => SizedBox(
                          height: 400,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 200,
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
                                        _datePickerItem(i),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Text(
                  "Wybierz datę",
                  style: Styles.smallTextButton,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(width: 30),
                  for (int i = DateTime.now().day; i <= numOfDaysInMonth; i++)
                    _dateBox(
                      i,
                      date: DateTime(
                        currentMonthAndYear["year"] as int,
                        DateTime.now().month,
                        i,
                      ),
                    ),
                ],
              ),
            ),
            _sideShadow(Alignment.centerLeft),
            _sideShadow(Alignment.centerRight),
          ],
        ),
      ],
    );
  }

  Widget _datePickerItem(int index) {
    bool isSelected = selectedMonthIndex == index;

    return Center(
      child: RotatedBox(
        quarterTurns: 1,
        child: Text(
          DateFormat("MMMM", "pl").format(
            DateTime(
              DateTime.now().year,
              index + 1,
            ),
          ),
          style:
              isSelected ? Styles.dateTextSelected : Styles.dateTextUnselected,
        ),
      ),
    );
  }

  Widget _sideShadow(Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        height: 90,
        width: 50,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theming.bgColor,
              blurRadius: 15,
              spreadRadius: 20,
              offset: alignment == Alignment.centerRight
                  ? const Offset(50, 0)
                  : const Offset(-50, 0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dateBox(
    int index, {
    required DateTime date,
  }) {
    bool isSelected = selectedDayIndex == index;
    String dayOfWeek = DateFormat("EEE", "pl").format(date);

    return GestureDetector(
      onTap: () {
        setState(() => selectedDayIndex = index);
      },
      child: AnimatedContainer(
        height: 90,
        width: 80,
        duration: const Duration(milliseconds: 300),
        curve: Curves.linearToEaseOut,
        margin: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: isSelected
              ? Theming.primaryColor
              : Theming.whiteTone.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                dayOfWeek.length > 4
                    ? dayOfWeek.replaceRange(4, null, ".")
                    : dayOfWeek,
                style: Styles.dateBoxText,
              ),
              const SizedBox(height: 4),
              Text(
                "${date.day}",
                style: Styles.dateBoxText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
