import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '/utils/theming.dart';

class DateTimeField extends StatefulWidget {
  final int index;
  final bool isStart;
  final Function(DateTime) onFinish;
  final List<int> errorFields;
  const DateTimeField({
    required this.index,
    required this.isStart,
    required this.onFinish,
    required this.errorFields,
    super.key,
  });

  @override
  State<DateTimeField> createState() => _DateTimeFieldState();
}

class _DateTimeFieldState extends State<DateTimeField> {
  DateTime? date;
  TimeOfDay? time;

  @override
  void initState() {
    super.initState();

    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () async {
              if (mounted) {
                final DateTime? selectedDate;
                selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(
                    DateTime.now().year + 15,
                    DateTime.now().month,
                    DateTime.now().day,
                  ),
                );
                setState(() => date = selectedDate);
              }
              if (mounted) {
                final TimeOfDay? selectedTime;
                selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                setState(() => time = selectedTime);
              }
              if (date != null && time != null) {
                widget.onFinish(
                  DateTime(
                    date!.year,
                    date!.month,
                    date!.day,
                    time!.hour,
                    time!.minute,
                  ),
                );
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15 / 2),
                  child: Text(
                    widget.isStart
                        ? AppLocalizations.of(context)!.partyStart.toUpperCase()
                        : AppLocalizations.of(context)!.partyEnd.toUpperCase(),
                    style: TextStyle(
                      color: widget.errorFields.contains(widget.index)
                          ? Theming.errorColor
                          : Theming.whiteTone.withOpacity(0.3),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                AnimatedContainer(
                  height: 100,
                  width: MediaQuery.of(context).size.width / 2 - 30 * 2,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.linearToEaseOut,
                  decoration: BoxDecoration(
                    color: Theming.whiteTone.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      width: 1.5,
                      color: widget.errorFields.contains(widget.index)
                          ? Theming.errorColor
                          : date != null && time != null
                              ? Theming.primaryColor
                              : Theming.whiteTone.withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          Icon(
                            Icons.date_range_outlined,
                            color: widget.errorFields.contains(widget.index)
                                ? Theming.errorColor
                                : date != null
                                    ? Theming.primaryColor
                                    : Theming.whiteTone.withOpacity(0.2),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            date != null
                                ? DateFormat.yMd(
                                    AppLocalizations.of(context)!.localeName,
                                  ).format(date!)
                                : AppLocalizations.of(context)!.partyDate,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: widget.errorFields.contains(widget.index)
                                  ? Theming.errorColor
                                  : date != null
                                      ? Theming.whiteTone
                                      : Theming.whiteTone.withOpacity(0.3),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 1.5,
                        width: MediaQuery.of(context).size.width / 2 - 30 * 2,
                        color: Theming.whiteTone.withOpacity(0.2),
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          Icon(
                            widget.isStart
                                ? Icons.wb_sunny_outlined
                                : Icons.nights_stay_rounded,
                            color: widget.errorFields.contains(widget.index)
                                ? Theming.errorColor
                                : time != null
                                    ? Theming.primaryColor
                                    : Theming.whiteTone.withOpacity(0.2),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            time != null
                                ? "${time!.hour}:${time!.minute} "
                                : AppLocalizations.of(context)!.partyTime,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: widget.errorFields.contains(widget.index)
                                  ? Theming.errorColor
                                  : time != null
                                      ? Theming.whiteTone
                                      : Theming.whiteTone.withOpacity(0.3),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 7.5,
              top: 2,
            ),
            child: Text(
              "• ${AppLocalizations.of(context)!.requiredField}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10,
                color: widget.errorFields.contains(widget.index)
                    ? Theming.errorColor
                    : Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
