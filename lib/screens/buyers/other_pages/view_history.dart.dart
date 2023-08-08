import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    List<Map<String, dynamic>> details = [
      {'title': "Product Name", 'subtitle': widget.product.name},
      {'title': "Quantity", 'subtitle': widget.order.quantity},
      {'title': "Total Amount", 'subtitle': widget.order.totalAmount},
      {'title': "Order/Tracking Id", 'subtitle': widget.order.id},
      {'title': "Delivery Address", 'subtitle': widget.order.deliveryAddress},
      {'title': "contact of buyer", 'subtitle': widget.order.contactInfo},
      {
        'title': "Date of order",
        'subtitle': DateFormat.yMMMMd().format(widget.order.dateOfOrder)
      },
      {
        'title': "Delivery date",
        'subtitle': widget.order.dateDelivered != null
            ? DateFormat.yMMMMd().format(widget.order.dateDelivered!)
            : "Not yet delivered"
      }
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My Order details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            ...details
                .map((e) => ListTile(
                      shape: const RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.black,
                              width: 0.5,
                              style: BorderStyle.solid,
                              strokeAlign: 0.5)),
                      title: e.isEmpty
                          ? const SizedBox.shrink()
                          : Text(e['title'].toString()),
                      subtitle: e.isEmpty
                          ? const SizedBox.shrink()
                          : Text(e['subtitle'].toString()),
                    ))
                .toList(),
            const SizedBox(
              height: 10,
            ),
            widget.order.isDelivered
                ? const Text("Completed")
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                          onPressed: () {}, child: const Text("Cancel Order")),
                      OutlinedButton(
                          onPressed: () {},
                          child: const Text("Track your order"))
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
