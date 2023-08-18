import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:map_commerce/models/user.dart';

class MyProfile extends StatefulWidget {
  final String userId;
  const MyProfile({super.key, required this.userId});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    final userStream = FirebaseFirestore.instance
        .collection("users")
        .doc(widget.userId)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        centerTitle: true,
      ),
      body: StreamBuilder<Object>(
          stream: userStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox.shrink();
            } else if (snapshot.hasError) {
              return const Text("Error Loading this page");
            }
            final data = snapshot.data as Map<String, dynamic>;

            return Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    const Center(
                      child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.amberAccent,
                          backgroundImage: NetworkImage("loading")),
                    ),
                    Positioned(
                        left: MediaQuery.of(context).size.width / 1.9,
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
                StreamBuilder<Object>(
                    stream: userStream,
                    builder: (context, snapshot) {
                      return Container(
                          child: const Column(
                        children: [],
                      ));
                    })
              ],
            );
          }),
    );
  }
}
