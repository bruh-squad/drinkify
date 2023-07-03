import 'package:flutter/material.dart' hide SearchController;
import 'package:latlong2/latlong.dart';

import '../widgets/partiespage/search_and_map.dart';
import '../widgets/partiespage/party_holder.dart';
import '../utils/theming.dart';
import '../models/party.dart';
import '../models/friend.dart';
import '../controllers/search_controller.dart';
import '../models/search_type.dart';

class PartiesPage extends StatefulWidget {
  const PartiesPage({super.key});

  @override
  State<PartiesPage> createState() => _PartiesPageState();
}

class _PartiesPageState extends State<PartiesPage> {
  late List<Party> parties;
  late SearchType searchType;
  @override
  void initState() {
    super.initState();
    searchType = SearchType.nearbyParties;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      parties = await SearchController.seachPartiesByDistance(1000);
    });
  }

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
                          privacyStatus: 1,
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
            SearchAndMap(
              onTypeSelect: (type) {},
            ),
          ],
        ),
      ),
    );
  }
}
