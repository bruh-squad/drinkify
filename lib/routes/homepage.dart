import 'package:flutter/material.dart';

import '../widgets/mainappbar.dart';
import '../widgets/homepage/partylist.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          children: const [
            MainAppBar(username: 'Adam'),
            PartyList(),
          ],
        ),
      ),
    );
  }
}
