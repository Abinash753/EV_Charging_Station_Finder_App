import 'dart:async';
import 'dart:math';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class HelperUtil {
  getPermission() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      return permission;
    } on Exception {
      print(Exception);
    }
  }

//error  occured in this code
  Stream<Coordinate> getCoordinateStream() {
    StreamController<Coordinate> controller = StreamController<Coordinate>();

    Stream<Position> positionStream = Geolocator.getPositionStream();
    // Stream<Coordinate> coordinateStream =
    //     positionStream.asyncExpand((Position position) async* {
    //   double lat = position.latitude;
    // double lat = 27.7172;
    // double long = 85.3240;
    //double long = position.longitude;
    // print("!!!!!!!!!!!!++++$lat");
    // print(long);
    //   String address = await getAddress(lat, long);
    //   yield Coordinate(latitude: lat, longitude: long, address: address);
    // });

    //coordinateStream.listen((Coordinate coordinate) {
    //controller.add(coordinate);
    //});

    return controller.stream;
  }

  getAddress(lat, long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    String address =
        placemarks[3].street! + ", " + placemarks[3].subAdministrativeArea!;
    return address;
  }

  double degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

//calculate distance
  double calculateDistance(
      double startLat, double startLng, double endLat, double endLng) {
    const int earthRadius = 6371;

    double startLatRadians = degreesToRadians(startLat);
    double startLngRadians = degreesToRadians(startLng);
    double endLatRadians = degreesToRadians(endLat);
    double endLngRadians = degreesToRadians(endLng);

    double latDiff = endLatRadians - startLatRadians;
    double lngDiff = endLngRadians - startLngRadians;

    double a = sin(latDiff / 2) * sin(latDiff / 2) +
        cos(startLatRadians) *
            cos(endLatRadians) *
            sin(lngDiff / 2) *
            sin(lngDiff / 2);
    // double a = pow(sin(latDiff / 2), 2) +
    //     cos(startLatRadians) * cos(endLatRadians) * pow(sin(lngDiff / 2), 2);
    double c = 2 * asin(sqrt(a));

    double distance = (earthRadius * c);
    return distance;
  }

  launchMaps(String address) async {
    final query = Uri.encodeComponent(address);
    final url = "https://www.google.com/maps/search/?api=1&query=$query";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}

class Coordinate {
  double? latitude;
  double? longitude;
  String? address;

  Coordinate({this.latitude, this.longitude, this.address});
}
