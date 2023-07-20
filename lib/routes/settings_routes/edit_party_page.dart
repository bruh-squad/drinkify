import 'package:flutter/material.dart';

import '/models/party.dart';
import '/utils/theming.dart';

class EditPartyPage extends StatelessWidget {
  final Party party;
  const EditPartyPage(
    this.party, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Theming.bgColor,
      resizeToAvoidBottomInset: false,
      body: null,
    );
  }
}
