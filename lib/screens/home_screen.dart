import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ev_connect_app/user_authentication/login_scree.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../google map/getUserLocation.dart';
import '../haversine_algorithm/station_distance.dart';
import 'drower/station_list.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //index for navigation button selection
  int index = 0;
  //navigation screens
  final screens = [
    const GoogleHome(),
    const ProfileScreen(),
    const UserForm()

    //const UserForm(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      //Button navigation
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            indicatorColor: Color.fromARGB(255, 220, 217, 217),
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            labelTextStyle: MaterialStateProperty.all(
                TextStyle(fontSize: 15, fontWeight: FontWeight.w500))),
        child: NavigationBar(
          backgroundColor: Colors.red,
          selectedIndex: index,
          animationDuration: const Duration(seconds: 2),
          onDestinationSelected: (index) => setState(() => this.index = index),
          destinations: const [
            NavigationDestination(
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                selectedIcon: Icon(
                  Icons.home,
                  color: Colors.red,
                  size: 30,
                ),
                label: "Home"),
            NavigationDestination(
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                selectedIcon: Icon(
                  Icons.person,
                  color: Colors.red,
                  size: 30,
                ),
                label: "Profile"),
            NavigationDestination(
                selectedIcon: Icon(
                  Icons.list,
                  color: Colors.red,
                ),
                icon: Icon(
                  Icons.list_alt,
                  color: Colors.white,
                  size: 30,
                ),
                label: "Station"),
          ],
        ),
      ),
    );
  }
}
//user tracking

class GoogleHome extends StatefulWidget {
  const GoogleHome({super.key});

  @override
  State<GoogleHome> createState() => _GoogleHomeState();
}

class _GoogleHomeState extends State<GoogleHome> {
//
  Completer<GoogleMapController> _googleMapController = Completer();
  CameraPosition? _cameraPosition;
  Location? _location;
  LocationData? _currentLocation;
  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    _location = Location();

    _cameraPosition = CameraPosition(
      target: LatLng(0, 0),
      zoom: 15,
    );
    _initLocation();
  }

  //function to listen when user move position
  _initLocation() {
    //user this to go to current location
    _location?.getLocation().then((location) {
      _currentLocation = location;
    });
    _location?.onLocationChanged.listen((newLocation) {
      _currentLocation = newLocation;
      moveToPostion(LatLng(
          _currentLocation?.latitude ?? 0, _currentLocation?.longitude ?? 0));
    });
  }

  //......................................................
  ///create map controller
  void onMapCreated(GoogleMapController controller) {
    if (!_googleMapController.isCompleted) {
      _googleMapController.complete(controller);
    }
  }

  @override
  void dispose() {
    _googleMapController = Completer();
    super.dispose();
  }

  moveToCurrentPosition() async {
    LocationData? currentLocation = await getCurrentLocation();
    moveToPostion(
      LatLng(currentLocation?.latitude ?? 0, currentLocation?.longitude ?? 0),
    );
  }

  //
  moveToPostion(LatLng latLng) async {
    GoogleMapController mapController = await _googleMapController.future;
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: 15),
      ),
    );
  }

  //get user current location
  Future<LocationData?> getCurrentLocation() async {
    var currentLocation = await _location?.getLocation();
    return currentLocation;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final exitApp = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("alert"),
                content: const Text("Do your want to Exit"),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text("No"),
                  ),
                  //yes button
                  ElevatedButton(
                    onPressed: () {
                      //when user pressed back button app exits
                      SystemNavigator.pop();
                    },
                    child: const Text("Yes"),
                  ),
                ],
              );
            });
        if (exitApp == true) {
          return Future.value(true);
        } else {
          return Future.value(false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Google Map",
            style: TextStyle(
                letterSpacing: 1.5,
                fontSize: 20,
                color: Color.fromARGB(255, 237, 8, 8)),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          //centerTitle: true,
          actions: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 20, top: 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    onPressed: () {
                      // Get.to(() => ProfileScreen());
                    },
                    icon: const Icon(
                      Icons.search,
                      size: 40,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        drawer: NavigationDrawer(),
        body: _buildBody(),
      ),
    );
  }

  //
  Widget _buildBody() {
    return _getMap();
  }

  //marker
  Widget _getMarker() {
    return Container(
      padding: const EdgeInsets.all(2),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(8, 3),
            spreadRadius: 4,
            blurRadius: 6,
          ),
        ],
      ),
      child: ClipOval(
          child: Image.asset(
        "assets/images/google_marker.png",
      )),
    );
  }

  //
  Widget _getMap() {
    return Stack(
      children: [
        GoogleMap(
            initialCameraPosition: _cameraPosition!,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              if (!_googleMapController.isCompleted) {
                _googleMapController.complete(controller);
              }
            }),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: _getMarker(),
          ),
        ),
      ],
    );
  }
}

//navigation Drawer
class NavigationDrawer extends StatelessWidget {
  NavigationDrawer({super.key});
  ProfileScreen profileScreen = const ProfileScreen();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 245, 238, 238),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeader(context),
          buildMenuItems(context),
        ],
      ),
    );
  }

  //header of the drawr
  Widget buildHeader(BuildContext context) => Material(
        color: const Color.fromARGB(255, 73, 5, 245),
        child: InkWell(
          onTap: () {
            //close navigation drawer before
            Navigator.pop(context);

            Get.to(() => const ProfileScreen());
          },
          child: Container(
            padding: EdgeInsets.only(
                top: 24 + MediaQuery.of(context).padding.top, bottom: 20),
            child: const Column(
              children: [
                CircleAvatar(
                  radius: 52,
                  backgroundImage: AssetImage("assets/images/user_profile.JPG"),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Abinash Upreti",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
                Text(
                  "abinashupreti1237@gmail.com",
                  style: TextStyle(fontSize: 15, color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      );
  //Items of the drawer
  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          runSpacing: 10, // vertical spacing
          children: [
            const SizedBox(
              height: 20,
            ),
            //home
            ListTile(
              leading: const Icon(
                Icons.home_outlined,
                color: Colors.red,
                size: 35,
              ),
              title: const Text(
                "Home",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),

            ListTile(
              leading: const Icon(Icons.person, color: Colors.red),
              title: const Text(
                "Profile",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Get.to(() => const ProfileScreen());
              },
            ),
            //charging station list
            ListTile(
              leading: const Icon(Icons.list, color: Colors.red),
              title: const Text(
                "Station List",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                //navigate to station list in drawer
                Get.to(() => const StationListScreen());
              },
            ),
            const Divider(),
            //logout
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                "Logout ",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                showAwesomeDialog(context);
                //logoutFunction(context);
              },
            ),
          ],
        ),
      );
}

//logout function
void showAwesomeDialog(BuildContext context) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.INFO,
    animType: AnimType.SCALE,
    title: 'Logout',
    desc: 'Are you sure want to logout !',
    btnCancelOnPress: () {
      Navigator.of(context).pop();
    },
    btnOkOnPress: () {
      FirebaseAuth.instance.signOut();
      Get.off(() => const LoginScreen());
    },
  ).show();
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) => Scaffold(
        // Dashboard Appbar
        appBar: AppBar(
          title: const Text(
            "Google Map",
            style:
                TextStyle(letterSpacing: 1.5, fontSize: 20, color: Colors.red),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          //centerTitle: true,
          actions: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 20, top: 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Get.to(() => const ProfileScreen());
                    },
                    icon: const Icon(
                      Icons.search,
                      size: 40,
                      color: Colors.red,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      const GetUserCurrentLocation();
                    },
                    child: const Icon(
                      Icons.map,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        //Draser  code stars from here
        drawer: NavigationDrawer(),
        body: const GoogleHome(),
      );
}

// body: StreamBuilder(
//   stream: FirebaseAuth.instance.authStateChanges(),
//   builder: (context, snapshot) {
//     //return LoginScreen();
// if (snapshot.connectionState == ConnectionState.waiting) {
//   return Center(
//     child: CircularProgressIndicator(),
//   );
// }
//    else if (snapshot.hasData) {
//     return const Home();
//   } else if (snapshot.hasError) {
//     ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Something Went Wrong !")));
//   } else
//     return const LoginScreen();
// },

//   SingleChildScrollView(
//     child: Container(
//       padding: const EdgeInsets.all(10),
//       child: Column(
//         children: [
//           const Text(
//             "Welcome to Dashboard",
//             style: TextStyle(
//               fontSize: 20,
//             ),
//           )
//         ],
//    ),
// );
