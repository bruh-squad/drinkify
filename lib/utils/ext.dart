import 'package:map_launcher/map_launcher.dart';

extension Capitalize on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

mixin MapUtils {
  /// Return **true** if opening a map succeded and **false** if failed.
  Future<bool> openMap({
    double lat = 0,
    double lng = 0,
  }) async {
    final List<AvailableMap> installedMaps = await MapLauncher.installedMaps;

    if (installedMaps.isNotEmpty) {
      await MapLauncher.showMarker(
        mapType: installedMaps[0].mapType,
        coords: Coords(lat, lng),
        title: "",
      );
      return true;
    }

    return false;
  }
}
