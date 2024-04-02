import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:map_commerce/models/product_model.dart';
import 'package:map_commerce/models/user_model.dart';

class SellerViewOrderDetails extends StatefulWidget {
  final UserModel user;
  final String orderId;
  final Product product;
  const SellerViewOrderDetails(
      {super.key,
      required this.user,
      required this.orderId,
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
    final orderStream = FirebaseFirestore.instance
        .collection("orders")
        .doc(widget.user.userId)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
      ),
      body: StreamBuilder<Object>(
          stream: orderStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator.adaptive();
            } else if (snapshot.hasError) {
              return const Text("Error Loading data");
            }

            return ListView.builder(itemBuilder: (context, index) {
              return;
            });
          }),
    );
  }
}

// ListTile(
//                     shape: const RoundedRectangleBorder(
//                         side: BorderSide(
//                             color: Colors.black,
//                             width: 0.5,
//                             style: BorderStyle.solid,
//                             strokeAlign: 0.5)),
//                     title: e.isEmpty
//                         ? const SizedBox.shrink()
//                         : Text(e['title'].toString()),
//                     subtitle: e.isEmpty
//                         ? const SizedBox.shrink()
//                         : Text(e['subtitle'].toString()),
//                   ))
//               .toList(),
//           widget.order.isDelivered
//               ? Text(widget.order.dateDelivered.toString())
//               : const SizedBox.shrink(),
//           const SizedBox(
//             height: 10,
//           ),
//           widget.order.isDelivered
//               ? const Text('Delivery Completed')
//               : OutlinedButton(onPressed: () {}, child: const Text('Pending'))
