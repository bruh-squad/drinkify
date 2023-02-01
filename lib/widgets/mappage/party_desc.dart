import 'package:flutter/material.dart';

import '/utils/theming.dart';

class PartyDesc extends StatelessWidget {
  const PartyDesc({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 110 - 100,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(0),
        children: const [
          SizedBox(height: 145),
          Text(
            '''
okeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokvokeokeokeokeokeok
okeokeokeokeokeokvjasdasdaokeokeokeokeokeokokeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeokeokokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeookeokeokeokeokeokkeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeok
okeokeokeokeokeokokeokeokeokeokeok
            ''',
            style: TextStyle(color: Theming.whiteTone),
          ),
          SizedBox(height: 120),
        ],
      ),
    );
  }
}
