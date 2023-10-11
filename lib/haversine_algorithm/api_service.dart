import 'package:cloud_firestore/cloud_firestore.dart';

class ApiService {
  sendValueToFirebase(
      double long, double lat, String address, String station) async {
    var data = {
      "latitude": lat,
      "longitude": long,
      "address": address,
      "station": station
    };
    await FirebaseFirestore.instance
        .collection('station')
        .add(data)
        .then((value) {});
  }
}
