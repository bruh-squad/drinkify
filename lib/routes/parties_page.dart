import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../widgets/partiespage/search_and_map.dart';
import '../widgets/partiespage/party_holder.dart';

import '../utils/theming.dart';
import '../models/party.dart';
import '../models/friend.dart';

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
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    const SizedBox(height: 130),
                    for (int i = 0; i < 5; i++)
                      PartyHolder(
                        party: Party(
                          owner: null,
                          ownerPublicId: "",
                          name: "Example party",
                          privacyStatus: PrivacyStatus.public,
                          description: "Example description of a party",
                          participants: [
                            const Friend(),
                          ],
                          location: LatLng(52.237049, 21.017532),
                          startTime: DateTime.now(),
                          stopTime: DateTime.now(),
                        ),
                      ),
                    SizedBox(
                      height: MediaQuery.of(context).viewPadding.bottom + 120,
                    ),
                  ],
                ),
              ),
            ),
            const SearchAndMap(),
          ],
        ),
      ),
    );
  }
}
