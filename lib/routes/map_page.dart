import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';
import 'package:go_router/go_router.dart';

import '../widgets/mappage/party_header.dart';
import '../widgets/mappage/party_desc.dart';
import '../utils/theming.dart';
import '../models/party_model.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  bool showMore = false;

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
                        center: LatLng(51.40253, 21.14714),
                        zoom: 15,
                        interactiveFlags: InteractiveFlag.all -
                            InteractiveFlag.doubleTapZoom -
                            InteractiveFlag.rotate,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                          userAgentPackageName: "com.example.alkoholicy",
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: LatLng(51.40253, 21.14714),
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
                        context.go("/");
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
              ],
            ),
            const SizedBox(height: 38),

            //Party info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Stack(
                children: [
                  PartyDesc(description: listOfParties[0].description),
                  PartyHeader(
                    partyName: listOfParties[0].name,
                    localisation: listOfParties[0].localisation,
                    participantsCount: listOfParties[0].participants.length,
                    startTime: listOfParties[0].startTime,
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
