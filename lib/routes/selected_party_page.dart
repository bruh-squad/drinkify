import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';
import 'package:go_router/go_router.dart';

import '../widgets/selectedpartypage/party_header.dart';
import '../widgets/selectedpartypage/party_desc.dart';
import '../utils/theming.dart';
import '../models/party.dart';
import '../api/directions.dart';

class LineString {
  List<dynamic> lineString;
  LineString(this.lineString);
}

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

  void getDirectionsData() async {
    try {
      data = await getData(
        widget.party.location.longitude,
        widget.party.location.latitude,
      );

      LineString ls = LineString(
        data['features'][0]['geometry']['coordinates'],
      );
      for (int i = 0; i < ls.lineString.length; i++) {
        polyPoints.add(
          LatLng(ls.lineString[i][1], ls.lineString[i][0]),
        );
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
    final double mapFullSize = MediaQuery.of(context).size.height - 120;
    const double mapShrinkedSize = 140;

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
                      ? Colors.black.withOpacity(0.3)
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
                  height: showMore ? mapShrinkedSize : mapFullSize,
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
                        offset: const Offset(0, 20),
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
                        center: LatLng(
                          widget.party.location.latitude,
                          widget.party.location.longitude,
                        ),
                        zoom: 15,
                        interactiveFlags: InteractiveFlag.all -
                            InteractiveFlag.doubleTapZoom -
                            InteractiveFlag.rotate,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                          userAgentPackageName: "app.drinkify",
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: LatLng(
                                widget.party.location.latitude,
                                widget.party.location.longitude,
                              ),
                              builder: (ctx) {
                                return const Icon(
                                  Icons.location_pin,
                                  color: Color.fromARGB(255, 233, 30, 98),
                                  size: 36,
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
                              color: Theming.primaryColor,
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
                        top: showMore ? mapShrinkedSize - 30 : mapFullSize - 30,
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
                _mapButton(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(top: 30, left: 30),
                  icon: Icons.arrow_back_rounded,
                  onClick: () {
                    if (showMore) return;
                    context.pop();
                  },
                ),

                //Get Path to location button
                _mapButton(
                  alignment: Alignment.topRight,
                  margin: const EdgeInsets.only(top: 30, right: 30),
                  icon: Icons.roundabout_right_outlined,
                  onClick: () {
                    if (showMore) return;
                    // getDirectionsData();
                  },
                ),
              ],
            ),

            AnimatedContainer(
              height: showMore ? 38 : 78,
              duration: const Duration(milliseconds: 500),
              curve: Curves.linearToEaseOut,
            ),

            //Party info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Stack(
                children: [
                  PartyDesc(description: widget.party.description),
                  PartyHeader(party: widget.party),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mapButton({
    required Alignment alignment,
    required EdgeInsets margin,
    required IconData icon,
    required VoidCallback onClick,
  }) {
    return Align(
      alignment: alignment,
      child: SafeArea(
        child: GestureDetector(
          onTap: onClick,
          child: AnimatedContainer(
            height: 40,
            width: 40,
            duration: const Duration(milliseconds: 200),
            curve: Curves.linearToEaseOut,
            margin: margin,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: showMore ? Colors.transparent : Theming.primaryColor,
              boxShadow: [
                BoxShadow(
                  color: showMore
                      ? Colors.transparent
                      : Colors.black.withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: showMore ? Colors.transparent : Theming.whiteTone,
            ),
          ),
        ),
      ),
    );
  }
}
