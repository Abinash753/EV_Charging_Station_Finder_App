import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'helper_util.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  double distance = 0.0;
  double? latitude, longitude;
  String? address, stationAddress;

  @override
  void initState() {
    getAddress();
    super.initState();
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
          //Access data from the document
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

  // getAddressOfCollege() async {
  //   var response = await FirebaseFirestore.instance.collection('station').get();

  //   var abc = response.docs.first;
  //   double stationLatitude = double.parse(abc.data()['latitude'].toString());

  //   double stationLongitude = double.parse(abc.data()['longitude'].toString());

  //   double calculatedDistance = HelperUtil().calculateDistance(
  //       latitude!, longitude!, stationLatitude, stationLongitude);

  //   String distanceString = calculatedDistance.toStringAsFixed(2);

  //   stationAddress = abc.data()['address'];

  //   setState(() {
  //     stationAddress = abc.data()['address'];
  //     distance = calculatedDistance;
  //   });
  //   setState(() {
  //     stationAddress;
  //     distance;
  //   });
  // }

  //fetching data

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Find Nearest EV Station "),
        ),
        body: Padding(
            padding: const EdgeInsets.only(
              left: 15,
            ),
            child:
                // stationAddress != null
                Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //first
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("stations")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Text("Error ${snapshot.error}");
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Text("No data is available");
                    }

                    //displaying the list of the station
                    return Expanded(
                      child: GridView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot doc =
                              snapshot.data!.docs[index];
                          final stationList =
                              doc.data() as Map<String, dynamic>;

                          // listtile to display the items
                          return SingleChildScrollView(
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: Color.fromARGB(255, 18, 240, 3),
                                    width: 3),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              margin: const EdgeInsets.only(
                                bottom: 10,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 7),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 190,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        child: Image.network(
                                          stationList['image'],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    // print(stationList['address']);

                                    Text(
                                      "Address: ${stationList['address']}",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Distance: ${HelperUtil().calculateDistance(27.7082, 85.3266, double.parse(stationList['latitude'].toString()), double.parse(stationList['longitude'].toString()))} KM",
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          await HelperUtil().launchMaps(
                                              stationList['address']!);
                                        },
                                        icon: const Icon(Icons.location_on))
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 210,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                      ),
                    );
                  },
                ),

                // SizedBox(
                //   height: 50,
                // ),
                // Text(
                //   "Longitude: ${longitude}",
                //   style: TextStyle(fontSize: 25),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // Text(
                //   "Latitude:${latitude}",
                //   style: TextStyle(fontSize: 25),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // Text(
                //   "Address:${address}",
                //   style: TextStyle(fontSize: 25),
                // ),

                // ListTile(
                //   title: Text("Chabahil"),
                //   subtitle: Text("chabahil station"),
                //   onTap: () {
                //        return Card(
                //               margin: const EdgeInsets.only(bottom: 10),
                //               child: Column(
                //                 children: [
                //                   Text(
                //                     "Address: ${stationList['address']}",
                //                     style: const TextStyle(
                //                         fontSize: 22,
                //                         fontWeight: FontWeight.bold),
                //                   ),
                //                   const SizedBox(
                //                     height: 5,
                //                   ),
                //                   Text(
                //                     "Distance: ${distance} KM",
                //                     style: const TextStyle(fontSize: 20),
                //                   ),
                //                   IconButton(
                //                       onPressed: () async {
                //                         await HelperUtil()
                //                             .launchMaps(stationAddress!);
                //                       },
                //                       icon: const Icon(Icons.location_on))
                //                 ],
                //               ),
                //             );
                //   },
                // ),

                // Card(
                //   child: Column(
                //     children: [
                //       Text(
                //         "College: Nist",
                //         style: TextStyle(fontSize: 25),
                //       ),
                //       SizedBox(
                //         height: 20,
                //       ),
                //       Text(
                //         "Address:${stationAddress ?? ""}",
                //         style: TextStyle(fontSize: 25),
                //       ),
                //       SizedBox(
                //         height: 20,
                //       ),
                //       Text(
                //         "Distance:${distance!} KM",
                //         style: TextStyle(fontSize: 25),
                //       ),
                //       IconButton(
                //           onPressed: () async {
                //             await HelperUtil().launchMaps(stationAddress!);
                //           },
                //           icon: Icon(Icons.location_on))
                //     ],
                //   ),
                // ),
                //second card
              ],
            )
            // : const Center(child: CircularProgressIndicator()),
            ),
      ),
    );
  }
}
