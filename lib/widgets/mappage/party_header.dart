import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/utils/theming.dart';
import '/utils/ext.dart' show openMap;

class PartyHeader extends StatelessWidget {
  final String party_name;
  final String localisation;
  final DateTime start_time;
  final int participants_count;
  const PartyHeader({
    super.key,
    required this.party_name,
    required this.localisation,
    required this.start_time,
    required this.participants_count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 110),
      decoration: const BoxDecoration(
        color: Theming.bgColor,
        boxShadow: [
          BoxShadow(
            color: Theming.bgColor,
            offset: Offset(0, 20),
            spreadRadius: 15,
            blurRadius: 15,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            party_name,
            style: Styles.partyHeaderTitle,
            maxLines: 1,
          ),
          Text(
            localisation,
            style: Styles.partyHeaderLocation,
          ),
          const SizedBox(height: 15),
          //Party info (date, time, number of people)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Date
              Row(
                children: [
                  const Icon(Icons.date_range_outlined,
                      color: Theming.primaryColor),
                  const SizedBox(width: 5),
                  Text(DateFormat.yMd().format(start_time), style: Styles.partyHeaderInfo)
                ],
              ),

              //Time
              Row(
                children: [
                  const Icon(Icons.timelapse, color: Theming.primaryColor),
                  const SizedBox(width: 5),
                  Text(DateFormat.Hm().format(start_time), style: Styles.partyHeaderInfo),
                ],
              ),

              //Number of people participating
              Row(
                children: [
                  const Icon(Icons.group_outlined, color: Theming.primaryColor),
                  const SizedBox(width: 5),
                  Text(participants_count.toString(), style: Styles.partyHeaderInfo),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
