import 'package:flutter/services.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:map_launcher/map_launcher.dart';

extension Capitalize on String {
  ///Turns the first letter to uppercase
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension StrConvert on String {
  ///Converts **POINT(lat lng)** to LatLng format
  LatLng toLatLng() {
    final point = replaceAll("POINT(", "").replaceAll(")", "").split(" ");
    return LatLng(
      double.parse(point[0]),
      double.parse(point[1]),
    );
  }

  ///Date bust have a **yyyy-mm-dd** format
  DateTime toDateTime() {
    List<String> dateArray = split("-");
    final convertedDate = DateTime(
      int.parse(dateArray[0]),
      int.parse(dateArray[1]),
      int.parse(dateArray[2]),
    );
    return convertedDate;
  }
}

extension DateTimeConvert on DateTime {
  ///Converts date to **yyyy-mm-dd** format
  String toYMD() => "$year-$month-$day";
}

extension LatLngConvert on LatLng {
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
      try {
        await MapLauncher.showMarker(
          mapType: installedMaps[0].mapType,
          coords: Coords(lat, lng),
          title: "",
        );
      } on PlatformException {
        return false;
      }
      return true;
    }

    return false;
  }
}

mixin LocationUtils {
  Future<LatLng?> userLocation() async {
    LatLng selPoint;
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    final Location location = Location();

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    final LocationData posData = await location.getLocation();

    selPoint = LatLng(
      posData.latitude!,
      posData.longitude!,
    );
    return selPoint;
  }
}
