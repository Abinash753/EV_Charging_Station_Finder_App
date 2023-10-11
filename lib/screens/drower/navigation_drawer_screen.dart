import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 165, 164, 164),
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
        color: const Color.fromARGB(255, 247, 87, 12),
        child: InkWell(
          onTap: () {
            //close navigation drawer before
            Navigator.pop(context);

            // Get.to(() => ProfileScreen());
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
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => ProfileScreen(),
                //   ),
                // );
                Navigator.pop(context);
              },
            ),
            //favourites
            ListTile(
              leading: const Icon(
                Icons.map,
                color: Colors.red,
              ),
              title: const Text(
                "Map Theme",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
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
                Get.off(() {
                  // StationListScreen();
                });
              },
            ),
            const Divider(),
            //logout
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                "Logout",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {},
            ),
          ],
        ),
      );
}
