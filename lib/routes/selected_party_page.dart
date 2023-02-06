import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';
import 'package:go_router/go_router.dart';

import '../widgets/mappage/party_header.dart';
import '../widgets/mappage/party_desc.dart';
import '../utils/theming.dart';
import '../models/party_model.dart';
import '../api/directions.dart';

class SelectedPartyPage extends StatefulWidget {
  final Party party;
  const SelectedPartyPage({Key? key, required this.party}) : super(key: key);

  @override
  State<SelectedPartyPage> createState() => _SelectedPartyPage();
}

class _SelectedPartyPage extends State<SelectedPartyPage> {
  bool showMore = false;
  late dynamic data;
  final List<LatLng> polyPoints = [];
  void getJsonData() async {
    try {
      data = await getData(widget.party.lnglat.longitude, widget.party.lnglat.latitude);

      LineString ls = LineString(
        data['features'][0]['geometry']['coordinates'],
      );
      for (int i = 0; i < ls.lineString.length; i++) {
        polyPoints.add(LatLng(ls.lineString[i][1], ls.lineString[i][0]));
      }
      if (polyPoints.length == ls.lineString.length) {
        //print(ls);
      }
    } catch (e) {
      //print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theming.bgColor,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 14, bottom: 25),
        child: GestureDetector(
          onTap: () {
            if (!showMore) return;
            //Some code
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.linearToEaseOut,
            decoration: BoxDecoration(
              color: showMore ? Theming.primaryColor : Colors.transparent,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: showMore
                      ? Colors.black.withOpacity(0.6)
                      : Colors.transparent,
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: Text(
              "Dołącz",
              style: TextStyle(
                color: showMore ? Theming.whiteTone : Colors.transparent,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            //Map
            Stack(
              children: [
                //Map
                AnimatedContainer(
                  width: double.infinity,
                  height: showMore
                      ? 140 // Map shrinked size
                      : MediaQuery.of(context).size.height - 150,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.linearToEaseOut,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 30,
                        offset: const Offset(0, 30),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                    child: FlutterMap(
                      options: MapOptions(
                        center: LatLng(widget.party.lnglat.latitude, widget.party.lnglat.longitude),
                        zoom: 15,
                        interactiveFlags:
                            InteractiveFlag.all - InteractiveFlag.doubleTapZoom,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                          userAgentPackageName: "app.example.drinkify",
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: LatLng(widget.party.lnglat.latitude, widget.party.lnglat.longitude),
                              builder: (ctx) {
                                return IconButton(
                                  onPressed: () {
                                    setState(() {
                                      showMore = true;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.location_on,
                                    color: Theming.bgColor,
                                    size: 36,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        PolylineLayer(
                          polylines: [
                            Polyline(
                              points: polyPoints,
                              strokeWidth: 4.0,
                              color: Colors.purple,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                //Show more button
                Align(
                  alignment: Alignment.topCenter,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        showMore = !showMore;
                      });
                    },
                    child: AnimatedContainer(
                      height: 60,
                      width: MediaQuery.of(context).size.width - 80,
                      alignment: Alignment.center,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.linearToEaseOut,
                      margin: EdgeInsets.only(
                        top: showMore
                            ? 110 //Map page shrinked size - 30
                            : MediaQuery.of(context).size.height - 180,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Theming.primaryColor,
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: Text(
                        showMore ? "Pokaż mniej" : "Zobacz więcej",
                        style: const TextStyle(
                          color: Theming.whiteTone,
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                ),

                //Back button
                Align(
                  alignment: Alignment.topLeft,
                  child: SafeArea(
                    child: GestureDetector(
                      onTap: () {
                        if (showMore) return;
                        context.go("/parties");
                      },
                      child: AnimatedContainer(
                        height: 40,
                        width: 40,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.linearToEaseOut,
                        margin: const EdgeInsets.only(top: 30, left: 30),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: showMore
                              ? Colors.transparent
                              : Theming.primaryColor,
                          boxShadow: [
                            BoxShadow(
                              color: showMore
                                  ? Colors.transparent
                                  : Colors.black.withOpacity(0.6),
                              blurRadius: 10,
                              spreadRadius: 1,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color:
                              showMore ? Colors.transparent : Theming.whiteTone,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: SafeArea(
                    child: GestureDetector(
                      onTap: () {
                        getJsonData();
                      },
                      child: AnimatedContainer(
                        height: 40,
                        width: 40,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.linearToEaseOut,
                        margin: const EdgeInsets.only(top: 30, right: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: showMore
                              ? Colors.transparent
                              : Theming.primaryColor,
                          boxShadow: [
                            BoxShadow(
                              color: showMore
                                  ? Colors.transparent
                                  : Colors.black.withOpacity(0.6),
                              blurRadius: 10,
                              spreadRadius: 1,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.pin_drop_sharp,
                          color:
                              showMore ? Colors.transparent : Theming.whiteTone,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 38),

            //Party info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Stack(
                children: [
                  PartyDesc(description: widget.party.description),
                  PartyHeader(
                    partyName: widget.party.name,
                    localisation: widget.party.localisation,
                    participantsCount: widget.party.participants.length,
                    startTime: widget.party.startTime,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LineString {
  LineString(this.lineString);
  List<dynamic> lineString;
}
