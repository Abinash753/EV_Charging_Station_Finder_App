import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ev_connect_app/haversine_algorithm/helper_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class StationListScreen extends StatefulWidget {
  const StationListScreen({super.key});

  @override
  State<StationListScreen> createState() => _StationListScreenState();
}

class _StationListScreenState extends State<StationListScreen> {
//fetching station list from firebase
  Stream<QuerySnapshot> fetchItems() {
    return FirebaseFirestore.instance.collection('stations').snapshots();
  }

  //make phone call
  Future<void> makePhoneCall(String phoneNumber) async {
    final url = "tel:$phoneNumber";
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  //fetching user phone number from firebase
//   Future<void> fetcPhoneNumber() async {
//   final User? user = FirebaseAuth.instance.currentUser;
//   if (user != null) {
//     final uid = user.uid; // Get the user's UID
//     final DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
//         .collection('stations')
//         .doc(uid)
//         .get();

//     if (userSnapshot.exists) {
//       final userData = userSnapshot.data() as Map<String, dynamic>;

  // For example, if you have a List of users:
//       List<Map<String, dynamic>> usersList = [userData];

  // Now, you can use this data to display in a ListTile or any other widget.
//     }
//   }
// }

  //final String phoneNumber = "9861025553";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Staton List ",
          style: TextStyle(
              color: Color.fromARGB(255, 235, 24, 9),
              letterSpacing: 1.3,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: fetchItems(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }

          final stationList = snapshot.data!.docs;
          return ListView.builder(
              itemCount: stationList.length,
              itemBuilder: (context, index) {
                final item = stationList[index].data() as Map<String, dynamic>;
                final stationName =
                    stationList[index]["station_name"] ?? "Null";
                final stationAddress = stationList[index]["address"] ?? "Null";
                //final stationContact = stationList[index]["contact"];
                final stationContact = item["contact"] ?? "0";
                return Container(
                  margin: const EdgeInsets.only(
                      top: 2, left: 6, right: 4, bottom: 3),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 3),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12))),
                  child: ListTile(
                    leading: Text(
                      '${index + 1}',
                      style: const TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    title: Text('$stationName',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    subtitle: Text('$stationAddress',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 15)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //call icon
                        IconButton(
                          icon: const Icon(Icons.call),
                          color: const Color.fromARGB(255, 3, 35, 243),
                          iconSize: 30,
                          padding: const EdgeInsets.all(1),
                          highlightColor:
                              const Color.fromARGB(255, 220, 15, 15),
                          splashColor: Colors.red,
                          focusColor: Colors.red,
                          disabledColor:
                              const Color.fromARGB(255, 158, 158, 158),
                          onPressed: () async {
                            // this function is used to call the users
                            if (stationContact != null &&
                                stationContact.isNotEmpty) {
                              await makePhoneCall(stationContact);
                            } else {}
                            await FlutterPhoneDirectCaller.callNumber(
                                stationContact);
                          },
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        //map direction icon
                        IconButton(
                          icon: const Icon(Icons.directions),
                          color: Colors.green,
                          iconSize: 30,
                          padding: const EdgeInsets.all(1),
                          highlightColor: Colors.black,
                          splashColor: Colors.red,
                          focusColor: Colors.red,
                          disabledColor:
                              const Color.fromARGB(255, 158, 158, 158),
                          onPressed: () async {
                            await HelperUtil().launchMaps(stationAddress);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }

  getAddress() async {
    try {
      LocationPermission permission = await HelperUtil().getPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        Stream<Coordinate> coordinateStream =
            HelperUtil().getCoordinateStream();
        coordinateStream.listen((event) async {
          //   setState(() {
          //     latitude = event.latitude;
          //     longitude = event.longitude;
          //     address = event.address;
          //   });

          //         FirebaseFirestore firestore = FirebaseFirestore.instance;
          //         CollectionReference collection = firestore.collection('station');

          //         QuerySnapshot querySnapshot = await collection.get();
          //         for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          //           //Access data from the document
          //           Map<String, dynamic> data =
          //               documentSnapshot.data() as Map<String, dynamic>;

          //Perform operations on the data
          // getAddressOfCollege();
          //         }

          //getAddressOfCollege("Nist");

          //ApiService() .sendValueToFirebase(longitude!, latitude!, address!, "Ugrachandi");
        });
      }
    } on Exception catch (_, ex) {
      print("Exception occured$ex");
    }
  }
}
