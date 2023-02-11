import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

// ignore: unused_element
Future<Position> _getCurrentLocation() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if (!serviceEnabled) return Future.error('Location service are disabled');

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permission denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error('Location permission denied forever');
  }

  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
  return position;
}

Future<dynamic> getData(double lng, double lat) async {
  // Position pos = await _getCurrentLocation();
  await dotenv.load(fileName: ".env");

  final String url =
      'https://api.openrouteservice.org/v2/directions/driving-car?api_key=${dotenv.env["OPENROUTESERVICE_APIKEY"]}&start=${21.200197},${51.414912}&end=$lat,$lng';

  http.Response response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    String data = response.body;

    return jsonDecode(data);
  } else {
    // print(response.statusCode);
  }
}

