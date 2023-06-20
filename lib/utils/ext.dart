import 'package:latlong2/latlong.dart';
import 'package:map_launcher/map_launcher.dart';

extension Capitalize on String {
  ///Turns the first letter to uppercase
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension POINTtoLatLng on String {
  ///Converts "POINT(lat lng)" to LatLng format
  LatLng toLatLng() {
    final point = replaceAll("POINT(", "").replaceAll(")", "").split(" ");
    return LatLng(
      double.parse(point[0]),
      double.parse(point[1]),
    );
  }
}

extension LatLngToPOINT on LatLng {
  ///Converts LatLng to "POINT(lat lng)" format
  String toPOINT() => "POINT($latitude $longitude)";
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
