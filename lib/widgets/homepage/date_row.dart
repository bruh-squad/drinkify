import 'package:flutter/material.dart';

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
  }

  Map<String, String> get monthAndYear {
    late String currentMonth;
    int dtMonth = DateTime.now().month;

    if (dtMonth == 1) currentMonth = "Styczeń";
    if (dtMonth == 2) currentMonth = "Luty";
    if (dtMonth == 3) currentMonth = "Marzec";
    if (dtMonth == 4) currentMonth = "Kwiecień";
    if (dtMonth == 5) currentMonth = "Maj";
    if (dtMonth == 6) currentMonth = "Czerwiec";
    if (dtMonth == 7) currentMonth = "Lipiec";
    if (dtMonth == 8) currentMonth = "Sierpień";
    if (dtMonth == 9) currentMonth = "Wrzesień";
    if (dtMonth == 10) currentMonth = "Październik";
    if (dtMonth == 11) currentMonth = "Listopad";
    if (dtMonth == 12) currentMonth = "Grudzień";

    return {
      "month": currentMonth,
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    builder: (context) {

                      //TODO implement scrolling vertically so you can change month/year
                      return SizedBox(
                        height: 300,
                        child: Center(
                          child: Text(
                            "${monthAndYear["month"]} ${monthAndYear["year"]}",
                            style: Styles.categoryText,
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
                  for (int i = 0; i < 10; i++)
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
        margin: const EdgeInsets.only(
          right: 20,
        ),
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
