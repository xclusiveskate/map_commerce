import 'package:flutter/material.dart';
import 'package:map_commerce/models/order.dart';
import 'package:map_commerce/models/product.dart';

class BuyerOrderDetails extends StatefulWidget {
  final Product product;
  final OrderModel order;
  const BuyerOrderDetails(
      {super.key, required this.product, required this.order});

  @override
  State<BuyerOrderDetails> createState() => _BuyerOrderDetailsState();
}

class _BuyerOrderDetailsState extends State<BuyerOrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My Order details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Row(
              children: [],
            ),
            widget.order.isDelivered
                ? const Text("Completed")
                : OutlinedButton(
                    onPressed: () {}, child: const Text("Track your order"))
          ],
        ),
      ),
    );
  }
}
