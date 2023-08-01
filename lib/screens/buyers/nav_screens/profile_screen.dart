import 'package:flutter/material.dart';
import 'package:map_commerce/controllers/auth.dart';

class BuyerProfileScreen extends StatefulWidget {
  const BuyerProfileScreen({super.key});

  @override
  State<BuyerProfileScreen> createState() => _BuyerProfileScreenState();
}

class _BuyerProfileScreenState extends State<BuyerProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          OutlinedButton(
              onPressed: () {
                Authentication.signOut();
              },
              child: const Text("Sign Out"))
        ],
      ),
    );
  }
}
