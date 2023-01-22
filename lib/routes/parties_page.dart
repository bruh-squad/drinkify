import 'package:flutter/material.dart';

import '../widgets/partiespage/search_and_map.dart';

import '../utils/theming.dart';

class PartiesPage extends StatelessWidget {
  const PartiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theming.bgColor,
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          //NavBar bottom margin + 60
          bottom: MediaQuery.of(context).padding.bottom + 40 + 60,
          right: 14,
        ),
        child: FloatingActionButton(
          backgroundColor: Theming.primaryColor,
          onPressed: () {},
          child: const Icon(
            Icons.add_rounded,
            color: Theming.whiteTone,
            size: 32,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 20,
          right: 30,
          left: 30,
        ),
        child: Column(
          children: const [
            SearchAndMap(),
          ],
        ),
      ),
    );
  }
}
