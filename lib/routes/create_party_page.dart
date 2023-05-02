import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:location/location.dart';

import '../utils/locale_support.dart';
import '../utils/theming.dart';

class CreatePartyRoute extends StatefulWidget {
  const CreatePartyRoute({super.key});

  @override
  State<CreatePartyRoute> createState() => _CreatePartyRouteState();
}

class _CreatePartyRouteState extends State<CreatePartyRoute> {
  var titleCtrl = TextEditingController();

  LatLng? selPoint;
  String? selLocation;
  final mapCtrl = MapController();

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void _getUserLocation(bool selectLocation) async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    final Location location = Location();

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    final LocationData posData = await location.getLocation();

    var loc = <Placemark>[];
    try {
      loc = await placemarkFromCoordinates(
        posData.latitude!,
        posData.longitude!,
      );
    } catch (_) {
      return;
    }

    final cityFields = <String>[
      loc[0].locality!,
      loc[0].administrativeArea!,
      loc[0].subAdministrativeArea!,
      loc[0].subLocality!,
    ];
    String locArea = "";

    for (final i in cityFields) {
      if (i != "") {
        locArea = i;
        break;
      }
    }

    bool addComma = locArea != "";

    if (mounted) {
      mapCtrl.move(
        LatLng(posData.latitude!, posData.longitude!),
        14,
      );
    }
    if (selectLocation) {
      setState(() {
        selPoint = LatLng(
          posData.latitude!,
          posData.longitude!,
        );
        selLocation =
            "${loc[0].country}${addComma ? ", $locArea" : ""}, ${loc[0].street}";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserLocation(false);
  }

  @override
  Widget build(BuildContext context) {
    final transl = LocaleSupport.appTranslates(context);

    return Scaffold(
      backgroundColor: Theming.bgColor,
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapCtrl,
            options: MapOptions(
              interactiveFlags: InteractiveFlag.all -
                  InteractiveFlag.doubleTapZoom -
                  InteractiveFlag.rotate,
              onTap: (_, pos) async {
                var loc = <Placemark>[];
                try {
                  loc = await placemarkFromCoordinates(
                    pos.latitude,
                    pos.longitude,
                  );
                } catch (_) {
                  return;
                }

                final cityFields = <String>[
                  loc[0].locality!,
                  loc[0].administrativeArea!,
                  loc[0].subAdministrativeArea!,
                  loc[0].subLocality!,
                ];
                String locArea = "";

                for (final i in cityFields) {
                  if (i != "") {
                    locArea = i;
                    break;
                  }
                }

                bool addComma = locArea != "";

                setState(() {
                  selPoint = pos;
                  selLocation =
                      "${loc[0].country}${addComma ? ", $locArea" : ""}, ${loc[0].street}";
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: "app.drinkify",
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: selPoint ?? LatLng(0, 0),
                    builder: (_) {
                      return Visibility(
                        visible: selPoint == null ? false : true,
                        child: const Icon(
                          Icons.location_pin,
                          color: Theming.primaryColor,
                          size: 36,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),

          // Return button, my location button
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).viewPadding.top + 10,
              left: 30,
              right: 30,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theming.bgColor.withOpacity(0.5),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Theming.whiteTone,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _getUserLocation(true),
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Theming.bgColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.my_location_rounded,
                          color: Theming.whiteTone,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          transl.myLocation,
                          style: const TextStyle(
                            color: Theming.whiteTone,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          DraggableScrollableSheet(
            maxChildSize: 1,
            initialChildSize: 0.16,
            minChildSize: 0.16,
            snap: true,
            builder: (ctx, scrollCtrl) {
              return Container(
                decoration: const BoxDecoration(
                  color: Theming.whiteTone,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: scrollCtrl,
                  child: Column(
                    children: [
                      Container(
                        height: 5,
                        width: MediaQuery.of(context).size.width / 5,
                        margin: const EdgeInsets.only(top: 5),
                        decoration: BoxDecoration(
                          color: Theming.bgColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.12 - 10,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                              ),
                              child: Text(
                                transl.location.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.2),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Stack(
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 30,
                                        ),
                                        child: Text(
                                          selLocation ?? transl.unknown,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _locationShadow(1),
                                    _locationShadow(-1),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(width: double.infinity),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.88,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Theming.bgColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 30,
                            right: 30,
                            top: 30,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _formField(
                                caption: transl.title,
                                ctrl: titleCtrl,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _formField({
    required String caption,
    required TextEditingController ctrl,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          caption.toUpperCase(),
          style: TextStyle(
            color: Theming.whiteTone.withOpacity(0.3),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theming.whiteTone.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }

  ///[leftRight] must be equal 1 or -1
  Widget _locationShadow(double leftRight) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theming.whiteTone,
            blurRadius: 15,
            spreadRadius: 20,
            offset: Offset(5 * leftRight, 20),
          ),
        ],
      ),
    );
  }
}
