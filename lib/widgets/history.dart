import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:map_commerce/models/order.dart';
import 'package:map_commerce/provider/admin.change.dart';
import 'package:map_commerce/screens/buyers/other_pages/view_history.dart.dart';
import 'package:map_commerce/screens/sellers/other_pages/view_order_history.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final orderStream =
      FirebaseFirestore.instance.collection('orders').snapshots();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final status = context.watch<AdminChanger>();
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: height / 30, horizontal: width / 40),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Transaction Histories",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            StreamBuilder(
                stream: orderStream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Error occurred while fetching data");
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    final List<QueryDocumentSnapshot> gottenOrders =
                        snapshot.data!.docs;

                    List<OrderModel> allOrders = gottenOrders
                        .map((doc) => OrderModel.fromFirestore(doc))
                        .toList();

                    var currentUserId = FirebaseAuth.instance.currentUser!.uid;

                    final orderForCurrentUser = allOrders
                        .where((element) => element.userId == currentUserId);

                    return allOrders.isEmpty
                        ? const Center(child: Text("No active order "))
                        : ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: status.isAdmin
                                ? allOrders.length
                                : orderForCurrentUser.length,
                            itemBuilder: (context, index) {
                              final order = allOrders[index];

                              final productOrdered = theProducts.firstWhere(
                                  (element) => element.id == order.productId);
                              final personThatOrdered = theUsers.where(
                                  (element) => element.userId == order.userId);
                              // final theDate = order.dateOfOrder;
                              // final date = DateFormat.yMMMMd().format(theDate);

                              return ListTile(
                                titleTextStyle: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                subtitleTextStyle: const TextStyle(
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                                shape: const RoundedRectangleBorder(
                                    side: BorderSide(
                                  color: Color(0xFF000000),
                                  width: 0.5,
                                  style: BorderStyle.solid,
                                  strokeAlign: 0.5,
                                )),
                                onTap: () {
                                  status.isAdmin
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SellerViewOrderDetails(
                                                      orderId: order.id,
                                                      product: productOrdered,
                                                      user: personThatOrdered
                                                          .first)))
                                      : Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BuyerOrderDetails(
                                                      product: productOrdered,
                                                      order: order)));
                                },
                                leading: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text("Quantity"),
                                    Text(order.quantity.toString())
                                  ],
                                ),
                                title: Text(productOrdered.name),
                                subtitle: Text(
                                    "Total Amount : \$${order.totalAmount.toString()}"),
                                trailing: order.isDelivered == true
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const Text("status"),
                                          OutlinedButton(
                                              onPressed: () {},
                                              child: const Text("Delivered"))
                                        ],
                                      )
                                    : const Column(
                                        children: [
                                          Text("status"),
                                          Text("pending")
                                        ],
                                      ),
                              );
                            });
                  }
                }),
          ],
        ),
      ),
    );
  }
}
