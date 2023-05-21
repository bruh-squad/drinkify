import 'package:flutter/material.dart';

import '/utils/theming.dart';

import '../widgets/homepage/welcome_header.dart';
import '../widgets/homepage/date_row.dart';
import '../widgets/homepage/party_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theming.bgColor,
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).viewPadding.top + 20,
        ),
        child: const Column(
          children: [
            //Had to use many paddings to make the DateRow boxes look better
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: WelcomeHeader(),
            ),
            DateRow(
              textPadding: EdgeInsets.symmetric(horizontal: 30),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: PartyList(),
            ),
          ],
        ),
      ),
    );
  }
}
