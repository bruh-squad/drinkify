import 'package:flutter/material.dart';

import '/utils/theming.dart';

class DateRow extends StatefulWidget {
  const DateRow({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Styczeń 2023",
              style: Styles.categoryText,
            ),
            Text(
              "Wybierz datę",
              style: Styles.smallTextButton,
            ),
          ],
        ),
        const SizedBox(height: 15),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 0; i < 10; i++)
                _dateBox(i, dayOfWeek: "Pon.", numberOfDay: i),
            ],
          ),
        ),
      ],
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
