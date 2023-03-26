import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
// import 'package:geolocator/geolocator.dart';

import '/widgets/custom_floating_button.dart';
import '/utils/theming.dart';

class ChooseLocationPage extends StatefulWidget {
  final Function(LatLng) onSave;
  const ChooseLocationPage({
    required this.onSave,
    super.key,
  });

  @override
  State<ChooseLocationPage> createState() => _ChooseLocationPageState();
}

class _ChooseLocationPageState extends State<ChooseLocationPage> {
  final mapCtrl = MapController();
  LatLng selPoint = LatLng(0, 0);

  String countryAndCity = "";
  String adress = "";
  late String formattedPoint;

  @override
  void initState() {
    super.initState();
    formattedPoint = "POINT(${selPoint.latitude} ${selPoint.longitude})";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theming.bgColor,
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapCtrl,
            options: MapOptions(
              onTap: (_, point) {
                setState(() => selPoint = point);
                formattedPoint = "POINT(${point.latitude} ${point.longitude})";
              },
              center: LatLng(52.237049, 21.017532),
              zoom: 15,
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
                    point: selPoint,
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
              context.pop();
            },
            child: const Text(
              "Zapisz",
              style: TextStyle(
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
