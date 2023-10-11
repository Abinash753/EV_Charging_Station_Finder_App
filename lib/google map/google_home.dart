import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleHome extends StatefulWidget {
  const GoogleHome({
    super.key,
  });

  @override
  State<GoogleHome> createState() => _GoogleHomeScreenState();
}

class _GoogleHomeScreenState extends State<GoogleHome> {
  //controller to store the state of the location
  Completer<GoogleMapController> _controller = Completer();
  //camera position for google map
  static final CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(27.7172, 85.3240),
    zoom: 14.4746,
  );

  List<Marker> _marker = [];
  final List<Marker> _list = const [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(27.708496, 85.34657),
      infoWindow: InfoWindow(
        title: "My Current Location",
      ),
    ),
    Marker(
      markerId: MarkerId('2'),
      position: LatLng(27.7278, 85.3782),
      infoWindow: InfoWindow(
        title: "My Destinatio Location",
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        initialCameraPosition: _cameraPosition,
        markers: Set<Marker>.of(_marker),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        });
  }
}

void floatingActionButton() {
  Completer<GoogleMapController> _controller = Completer();
  FloatingActionButton(
      child: const Icon(Icons.location_disabled_outlined),
      onPressed: () async {
        GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(27.708496, 85.34657),
            zoom: 14,
          ),
        ));
        //setState(() {});
      });
}
