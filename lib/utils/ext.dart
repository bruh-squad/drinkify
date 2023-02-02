import 'package:map_launcher/map_launcher.dart';

extension Capitalize on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

Future<void> openMap({
  String? adress,
  double lat = 0,
  double lng = 0,
}) async {
  final List<AvailableMap> installedMaps = await MapLauncher.installedMaps;

  if (installedMaps.isNotEmpty) {
    MapLauncher.showMarker(
      mapType: installedMaps[0].mapType,
      coords: Coords(lat, lng),
      title: "",
    );
  }
}
