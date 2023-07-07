import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/utils/ext.dart' show Capitalize;
import '/utils/theming.dart';
import '/models/user.dart';
import './date_picker.dart';

class DateRow extends StatefulWidget {
  final User user;
  final EdgeInsets textPadding;
  const DateRow(
    this.user, {
    required this.textPadding,
    super.key,
  });

  @override
  State<DateRow> createState() => _DateRowState();
}

class _DateRowState extends State<DateRow> {
  late int selectedDayIndex;
  late int selectedMonthIndex;
  late int selectedYearIndex;
  late List<int> date;

  @override
  void initState() {
    super.initState();
    selectedDayIndex = DateTime.now().day;
    selectedMonthIndex = DateTime.now().month - 1;
    selectedYearIndex = DateTime.now().year;
    date = [
      DateTime.now().year,
      DateTime.now().month,
    ];

    initializeDateFormatting();
  }

  int _numOfDaysInMonth(int year, int month) {
    return DateTime(
      year,
      month + 1,
      0,
    ).day;
  }

  //type must be MONTH else it will be considered as YEAR
  String toMonthName(DateTime date) {
    return DateFormat("MMMM", AppLocalizations.of(context)!.localeName)
        .format(date)
        .toString()
        .capitalize();
  }

  @override
  Widget build(BuildContext context) {
    final String month = toMonthName(DateTime(date[0], date[1]));

    final int dateBoxStart =
        date[1] != DateTime.now().month || date[0] != DateTime.now().year
            ? 1
            : DateTime.now().day;

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
                "$month ${date[0]}",
                style: Styles.categoryText,
              ),
              TextButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Theming.bgColor,
                    useRootNavigator: true,
                    enableDrag: false,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    builder: (_) => DatePicker(
                      onSelect: (year, month) {
                        setState(() {
                          date[0] = year + DateTime.now().year;
                          date[1] = month;
                        });

                        if (date[0] == DateTime.now().year &&
                            date[1] == DateTime.now().month) {
                          setState(() => selectedDayIndex = DateTime.now().day);
                        } else {
                          setState(() => selectedDayIndex = 1);
                        }
                      },
                    ),
                  );
                },
                child: Text(
                  AppLocalizations.of(context)!.pickADate,
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
                  for (int i = dateBoxStart;
                      i <= _numOfDaysInMonth(date[0], date[1]);
                      i++)
                    _dateBox(
                      i,
                      boxDate: DateTime(
                        date[0],
                        date[1],
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
    required DateTime boxDate,
  }) {
    bool isSelected = selectedDayIndex == index;
    String dayOfWeek = DateFormat(
      "EEE",
      AppLocalizations.of(context)!.localeName,
    ).format(boxDate);

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
                "${boxDate.day}",
                style: Styles.dateBoxText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
