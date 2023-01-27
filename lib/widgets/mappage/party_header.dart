import 'package:flutter/material.dart';

import '/utils/theming.dart';

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
          const Text(
            "Radom, ul. chuj wie gdzie 69",
            style: Styles.partyHeaderLocation,
          ),
          const SizedBox(height: 15),
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
