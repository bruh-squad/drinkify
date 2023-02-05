import 'dart:convert';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

const String API_KEY ='5b3ce3597851110001cf6248043c379d412b4a69be49f562009ea803';

Future<Position> _getCurrentLocation() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if(!serviceEnabled){
    return Future.error('Location service are disabled');
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if(permission == LocationPermission.denied){
    permission = await Geolocator.requestPermission();
    if(permission == LocationPermission.denied){
      return Future.error('Location permission denied');
    }
  }
  if(permission == LocationPermission.deniedForever){
    return Future.error('Location permission denied forever');
  }

  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  return position;
}

Future getData(double lng, double lat) async {

  Position pos = await _getCurrentLocation();

  final String url = 'https://api.openrouteservice.org/v2/directions/driving-car?api_key=${API_KEY}&start=${21.200197},${51.414912}&end=${lat},${lng}';

  http.Response response = await http.get(Uri.parse(url));
  print(url);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
}