import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:map_commerce/models/order.dart';
import 'package:map_commerce/models/product.dart';
import 'package:map_commerce/models/user.dart';

class SellerViewOrderDetails extends StatefulWidget {
  final UserModel user;
  final OrderModel order;
  final Product product;
  const SellerViewOrderDetails(
      {super.key,
      required this.user,
      required this.order,
      required this.product});

  @override
  State<SellerViewOrderDetails> createState() => _SellerViewOrderDetailsState();
}

class _SellerViewOrderDetailsState extends State<SellerViewOrderDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> details = [
      {'title': "Product Name", 'subtitle': widget.product.name},
      {'title': "Quantity", 'subtitle': widget.order.quantity},
      {'title': "Total Amount", 'subtitle': widget.order.totalAmount},
      {'title': "Order/Tracking Id", 'subtitle': widget.order.id},
      {'title': "Name of buyer", 'subtitle': widget.user.displayName},
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
        title: const Text("Order Details"),
      ),
      body: Column(
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
          widget.order.isDelivered
              ? Text(widget.order.dateDelivered.toString())
              : const SizedBox.shrink(),
          const SizedBox(
            height: 10,
          ),
          widget.order.isDelivered
              ? const Text('Delivery Completed')
              : OutlinedButton(onPressed: () {}, child: const Text('Pending'))
        ],
      ),
    );
  }
}
