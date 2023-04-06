import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

import '/widgets/custom_floating_button.dart';
import '/utils/locale_support.dart';
import '/utils/theming.dart';

LatLng? selPoint;

class ChooseLocationPage extends StatefulWidget {
  final Function(String) onSave;
  const ChooseLocationPage({
    required this.onSave,
    super.key,
  });

  @override
  State<ChooseLocationPage> createState() => _ChooseLocationPageState();
}

class _ChooseLocationPageState extends State<ChooseLocationPage> {
  final MapController mapCtrl = MapController();
  final LatLng centerOfEurope = LatLng(55.18194, 28.25833);

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void _getUserLocation() async {
    late bool serviceEnabled;
    late PermissionStatus permissionGranted;
    Location location = Location();

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
    setState(() {
      selPoint = LatLng(
        posData.latitude!,
        posData.longitude!,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final transl = LocaleSupport.appTranslates(context);
    return Scaffold(
      backgroundColor: Theming.bgColor,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: 55 + MediaQuery.of(context).padding.bottom,
        ),
        child: FloatingActionButton(
          onPressed: () => _getUserLocation(),
          backgroundColor: Theming.primaryColor,
          child: const Icon(
            Icons.person_pin_circle,
            color: Theming.whiteTone,
            size: 32,
          ),
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapCtrl,
            options: MapOptions(
              onTap: (_, point) {
                setState(() => selPoint = point);
              },
              center: centerOfEurope,
              zoom: 3,
              interactiveFlags: InteractiveFlag.all -
                  InteractiveFlag.doubleTapZoom -
                  InteractiveFlag.rotate,
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
          Align(
            alignment: Alignment.topCenter,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top - 15,
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width -
                        (MediaQuery.of(context).size.width - 100),
                    child: _returnButton(
                      icon: Icons.arrow_back_rounded,
                      onClick: () => context.pop(),
                    ),
                  ),
                ),
                const Spacer(),
                FittedBox(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 100,
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top,
                      bottom: 15,
                    ),
                    decoration: BoxDecoration(
                      color: Theming.bgColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(60),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 1,
                          offset: const Offset(-5, 5),
                        ),
                      ],
                    ),
                    child: const Text(
                      "Polska, Radom",
                      style: TextStyle(
                        color: Theming.whiteTone,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 95 + MediaQuery.of(context).padding.bottom,
              width: double.infinity,
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Theming.bgColor.withOpacity(0.6),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: const Text(
                "Lubelska 91a",
                style: TextStyle(
                  color: Theming.whiteTone,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          CustomFloatingButton(
            backgroundColor: Theming.primaryColor,
            onTap: () {
              if (selPoint == null) return;
              widget.onSave(
                "POINT(${selPoint?.latitude} ${selPoint?.longitude})",
              );
              context.pop();
            },
            child: Text(
              transl.save,
              style: const TextStyle(
                color: Theming.whiteTone,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _returnButton({
    required IconData icon,
    required VoidCallback onClick,
  }) {
    return GestureDetector(
      onTap: onClick,
      child: AnimatedContainer(
        height: 40,
        width: 40,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linearToEaseOut,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theming.bgColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: Theming.whiteTone,
        ),
      ),
    );
  }
}
