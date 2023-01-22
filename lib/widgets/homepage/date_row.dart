import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '/utils/ext.dart';
import '/utils/theming.dart';

class DateRow extends StatefulWidget {
  final EdgeInsets textPadding;
  const DateRow({required this.textPadding, super.key});

  @override
  State<DateRow> createState() => _DateRowState();
}

class _DateRowState extends State<DateRow> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
    initializeDateFormatting();
  }

  List<String> months = const [
    "Styczeń",
    "Luty",
    "Marzec",
    "Kwiecień",
    "Maj",
    "Czerwiec",
    "Lipiec",
    "Sierpień",
    "Wrzesień",
    "Październik",
    "Listopad",
    "Grudzień",
  ];

  Map<String, String> get monthAndYear {
    return {
      "month": DateFormat("MMMM", "pl")
          .format(DateTime.now())
          .toString()
          .capitalize(),
      "year": DateTime.now().year.toString(),
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
                "${monthAndYear["month"]} ${monthAndYear["year"]}",
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
                      return SizedBox(
                        height: 340,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 150,
                                width: 150,
                                child: ListWheelScrollView(
                                  itemExtent: 60,
                                  physics: const FixedExtentScrollPhysics(),
                                  diameterRatio: 4,
                                  onSelectedItemChanged: (val) {},
                                  children: [
                                    for (final i in months)
                                      Text(i, style: Styles.dateTextSelected),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 40),
                              SizedBox(
                                height: 150,
                                width: 150,
                                child: ListWheelScrollView(
                                  itemExtent: 60,
                                  physics: const FixedExtentScrollPhysics(),
                                  diameterRatio: 4,
                                  children: [
                                    Text(
                                      monthAndYear["year"]!,
                                      style: Styles.dateTextSelected,
                                    ),
                                    Text(
                                      monthAndYear["year"]!,
                                      style: Styles.dateTextSelected,
                                    ),
                                    Text(
                                      monthAndYear["year"]!,
                                      style: Styles.dateTextSelected,
                                    ),
                                    Text(
                                      monthAndYear["year"]!,
                                      style: Styles.dateTextSelected,
                                    ),
                                    Text(
                                      monthAndYear["year"]!,
                                      style: Styles.dateTextSelected,
                                    ),
                                    Text(
                                      monthAndYear["year"]!,
                                      style: Styles.dateTextSelected,
                                    ),
                                  ],
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
                  for (int i = 1; i < 10; i++)
                    _dateBox(i, dayOfWeek: "Pon.", numberOfDay: i),
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
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 80),
        opacity: 1,
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
                    ? const Offset(45, 0)
                    : const Offset(-45, 0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dateBox(
    int index, {
    required String dayOfWeek,
    required int numberOfDay,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() => selectedIndex = index);
      },
      child: Container(
        height: 90,
        width: 80,
        margin: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Theming.primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                dayOfWeek,
                style: Styles.dateBoxText,
              ),
              const SizedBox(height: 4),
              Text(
                "$numberOfDay",
                style: Styles.dateBoxText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
