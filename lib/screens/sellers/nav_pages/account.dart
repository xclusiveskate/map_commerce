import 'package:flutter/material.dart';
import 'package:map_commerce/controllers/auth.dart';

class ShopProfilePage extends StatefulWidget {
  const ShopProfilePage({super.key});

  @override
  State<ShopProfilePage> createState() => _ShopProfilePageState();
}

class _ShopProfilePageState extends State<ShopProfilePage> {
  signOut() async {
    Authentication.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
          onPressed: () {
            signOut();
          },
          child: const Text("Sign Out")),
    );
  }
}
