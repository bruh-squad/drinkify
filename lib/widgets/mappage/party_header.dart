import 'package:flutter/material.dart';

import '/utils/theming.dart';
import '/utils/ext.dart' show openMap;

class PartyHeader extends StatelessWidget {
  const PartyHeader({super.key});

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
          const Text(
            "18 Kamila",
            style: Styles.partyHeaderTitle,
            maxLines: 1,
          ),
          GestureDetector(
            onTap: () {
              openMap(lat: 51.40253, lng: 21.14714);
            },
            child: Row(
              children: [
                const Text(
                  "Radom, ul. chuj wie gdzie 69",
                  style: Styles.partyHeaderLocation,
                ),
                const SizedBox(width: 5),
                Icon(
                  Icons.link_sharp,
                  color: Theming.whiteTone.withOpacity(0.6),
                  size: 18,
                )
              ],
            ),
          ),
          const SizedBox(height: 15),
          //Party info (date, time, number of people)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Date
              Row(
                children: const [
                  Icon(Icons.date_range_outlined, color: Theming.primaryColor),
                  SizedBox(width: 5),
                  Text("28.01.2023", style: Styles.partyHeaderInfo)
                ],
              ),

              //Time
              Row(
                children: const [
                  Icon(Icons.timelapse, color: Theming.primaryColor),
                  SizedBox(width: 5),
                  Text("12:00", style: Styles.partyHeaderInfo),
                ],
              ),

              //Number of people participating
              Row(
                children: const [
                  Icon(Icons.group_outlined, color: Theming.primaryColor),
                  SizedBox(width: 5),
                  Text("21", style: Styles.partyHeaderInfo),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
