import 'package:alkoholicy/utils/theming.dart';
import 'package:flutter/material.dart';

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
          top: MediaQuery.of(context).padding.top + 20,
          right: 30,
          left: 30,
        ),
        child: Column(
          children: const [
            WelcomeHeader(),
            DateRow(),
            PartyList(),
          ],
        ),
      ),
    );
  }
}
