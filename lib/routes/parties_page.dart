import 'package:flutter/material.dart';

import '../widgets/partiespage/search_and_map.dart';
import '../widgets/partiespage/party_holder.dart';

import '../utils/theming.dart';
import 'package:drinkify/models/party_model.dart';

class PartiesPage extends StatelessWidget {
  const PartiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theming.bgColor,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 20,
          right: 30,
          left: 30,
        ),
        child: Column(
          children: [
            const SearchAndMap(),
            PartyHolder(partyList: listOfParties),
          ],
        ),
      ),
    );
  }
}
