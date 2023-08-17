import 'package:flutter/material.dart';
import 'package:map_commerce/models/user.dart';

class MyProfile extends StatefulWidget {
  final UserModel user;
  const MyProfile({super.key, required this.user});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.amberAccent,
                  backgroundImage:
                      NetworkImage(widget.user.imageUrl ?? "loading")),
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
        ],
      ),
    );
  }
}
