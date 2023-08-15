// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:map_commerce/controllers/database.dart';
import 'package:map_commerce/models/product.dart';
import 'package:map_commerce/screens/buyers/buyer.dart';

import 'package:map_commerce/utils/snackbar.dart';

class OrderPage extends StatefulWidget {
  final int quantity;
  final int total;
  final Product product;
  const OrderPage(
      {super.key,
      required this.quantity,
      required this.total,
      required this.product});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  TextEditingController addressController = TextEditingController();
  TextEditingController googleAddressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  createOrder() async {
    try {
      await Database.createOrder(
          productId: widget.product.id!,
          phoneNumber: int.parse(phoneController.text),
          address: addressController.text,
          nearbyAddress: googleAddressController.text,
          quantity: widget.quantity,
          total: widget.total);

      showSnackBar(
          context: context,
          message: 'You order has been submitted successfully');
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
          (route) => false);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact information page "),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: addressController,
                decoration: const InputDecoration(
                    labelText: "input your current/delivery address"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: googleAddressController,
                decoration:
                    const InputDecoration(labelText: "pick a nearby location"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                    labelText: "input your  phone number"),
              ),
            ),
            OutlinedButton(
                onPressed: () {
                  createOrder();
                },
                child: const Text("Complete Order"))
          ],
        ),
      ),
    );
  }
}
