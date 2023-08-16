import 'package:flutter/material.dart';
import 'package:map_commerce/controllers/auth.dart';
import 'package:map_commerce/models/user.dart';
import 'package:map_commerce/screens/buyers/other_pages/account.dart';

class BuyerProfileScreen extends StatefulWidget {
  const BuyerProfileScreen({super.key});

  @override
  State<BuyerProfileScreen> createState() => _BuyerProfileScreenState();
}

class _BuyerProfileScreenState extends State<BuyerProfileScreen> {
  UserModel? user;
  List tiles = [
    {"icon": Icons.person, "name": "My Account"},
    {"icon": Icons.notifications, "name": "Notifications"},
    {"icon": Icons.settings, "name": "Settings"},
    {"icon": Icons.help_outline, "name": "Help Center"},
    {"icon": Icons.logout_rounded, "name": "Log Out"},
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blueAccent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 0.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Profile",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.amberAccent,
                  ),
                  Positioned(
                      left: MediaQuery.of(context).size.width / 6,
                      top: 78,
                      child: IconButton(
                          iconSize: 35,
                          color: Colors.greenAccent,
                          onPressed: () {},
                          icon: const Icon(Icons.camera_alt_outlined)))
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              ...tiles
                  .map((e) => Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
                          tileColor: Colors.amber.withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          contentPadding: const EdgeInsets.all(6.0),
                          onTap: () => switch (e['name']) {
                            "My Account" => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MyAccountPage(userId: user?.userId))),
                            "Log Out" => Authentication.signOut(),
                            _ => ""
                          },
                          leading: Icon(
                            e['icon'],
                            size: 30,
                          ),
                          title: Text(
                            e['name'],
                            style: const TextStyle(fontSize: 20),
                          ),
                          trailing: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.arrow_forward_outlined)),
                        ),
                      ))
                  .toList()
            ],
          ),
        ),
      ),
    );
  }
}

//  child: OutlinedButton(
//                       onPressed: () {
//                         Authentication.signOut();
//                       },
//                       child: const Text("Sign Out"))