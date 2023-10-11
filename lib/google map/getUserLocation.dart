import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetUserCurrentLocation extends StatefulWidget {
  const GetUserCurrentLocation({super.key});

  @override
  State<GetUserCurrentLocation> createState() => _GetUserCurrentLocationState();
}

class _GetUserCurrentLocationState extends State<GetUserCurrentLocation> {
  final Completer<GoogleMapController> _controller = Completer();
//seting latlng and  to the camera position
  static const CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(27.708496, 85.34657),
    zoom: 14,
  );

  final List<Marker> _markes = const <Marker>[
    Marker(
      markerId: MarkerId("1"),
      position: LatLng(27.708496, 85.34657),
      infoWindow: InfoWindow(title: "My current Location"),
    ),
  ];
  //function to get user current location
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("Error: " + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _cameraPosition,
        markers: Set<Marker>.of(
          _markes,
        ),
        onMapCreated: (GoogleMapController controlller) {
          _controller.complete(controlller);
        },
      ),
      //floating action button for getting user current location
      floatingActionButton: FloatingActionButton(onPressed: () {
        //function calling to get user current location
        getUserCurrentLocation().then((value) {
          print("My current Location");
          print(value.latitude.toString() + " " + value.longitude.toString());
        });
      }),
    );
  }
}
