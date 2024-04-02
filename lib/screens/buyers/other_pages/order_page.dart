// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart' as serv;
import 'package:map_commerce/constants/constants.dart';
import 'package:map_commerce/controllers/database.dart';
import 'package:map_commerce/controllers/payment.dart';
import 'package:map_commerce/models/user_model.dart';
import 'package:map_commerce/provider/cart._provider.dart';
import 'package:map_commerce/screens/buyers/other_pages/status_page.dart';
import 'package:map_commerce/utils/snackbar.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  // final int quantity;
  // final int total;
  // final Product product;
  const OrderPage({
    super.key,
    // required this.quantity,
    // required this.total,
    // required this.product
  });

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  TextEditingController addressController = TextEditingController();
  TextEditingController googleAddressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  // createOrder(txid) async {
  //   try {
  //     await Database.createOrder(
  //         product: widget.product,
  //         phoneNumber: int.parse(phoneController.text),
  //         address: addressController.text,
  //         nearbyAddress: googleAddressController.text,
  //         quantity: widget.quantity,
  //         transId: txid,
  //         total: widget.total);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("CheckOut Page "),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 36.0),
              // ignore: avoid_unnecessary_containers
              child: Container(
                child: Column(
                  children: [
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Additional Information",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
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
                        readOnly: true,
                        onTap: () async {
                          final value = await googleAutoPlace();
                          if (value!.isNotEmpty) {
                            print("pciked address: $value");
                            setState(() {
                              googleAddressController.text = value;
                            });
                          }
                        },
                        decoration: const InputDecoration(
                            labelText: "Tap to pick a nearby location"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: phoneController,
                        keyboardType: const TextInputType.numberWithOptions(),
                        decoration: const InputDecoration(
                            labelText: "input your  phone number"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              elevation: 1,
              shadowColor: Colors.amber,
              shape:
                  const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Order Summary",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    ...cart.cartList
                        .map((e) => ListTile(
                              title: Text(e.product.name),
                              subtitle: Text(e.product.amount.toString()),
                              trailing: Text(e.quantity.toString()),
                            ))
                        .toList()
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 55,
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\$${cart.getTotalPrice().toString()}',
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      minimumSize:
                          Size(MediaQuery.of(context).size.width / 2.0, 50),
                      backgroundColor: Colors.amber),
                  onPressed: () async {
                    if (addressController.text.isNotEmpty &&
                        googleAddressController.text.isNotEmpty &&
                        phoneController.text.isNotEmpty) {
                      String id = Database.user;
                      final data = await FirebaseFirestore.instance
                          .collection('users')
                          .doc(id)
                          .get()
                          .then((value) => UserModel.fromFirestore(value));

                      final res = await paymentMethod.payWithPaystack(
                          context: context,
                          amount: cart.getTotalPrice(),
                          email: data.email!);

                      print(' payment status : ${res.status} : ${res.ref}');

                      if (res.status) {
                        if (context.mounted) {
                          cart.cartList.clear();
                          await Database.createOrder(
                            items: cart.cartList,
                            phoneNumber: int.parse(phoneController.text),
                            address: addressController.text,
                            nearbyAddress: googleAddressController.text,
                            transId: res.ref,
                            total: cart.getTotalPrice(),
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentStatusPage(
                                response: res,
                                amount: cart.getTotalPrice(),
                              ),
                            ),
                          );
                        }
                      }
                    } else {
                      showSnack(
                          context: context,
                          message:
                              'fill all the additional information fields above');
                    }
                    // createOrder();
                  },
                  icon: const Icon(Icons.payment),
                  label: const Text(
                    "Proceed to Payment",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
            ),
          ],
        ),
      ],
    );
  }

  Future<String?> googleAutoPlace() async {
    serv.Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: googleApiKey,
      offset: 0,
      radius: 10000,
      strictbounds: false,
      region: "ng",
      language: "en",
      mode: Mode.overlay,
      components: [serv.Component(serv.Component.country, "ng")],
      types: [],
      hint: "search city",
      onError: (value) => print(value.errorMessage.toString()),
    );
    String? address;
    try {
      if (p != null) {
        final newLang = p.description.toString();
        print(newLang);
        print(p.placeId.toString());
        print(p.reference.toString());
        final plist = serv.GoogleMapsPlaces(
            apiKey: googleApiKey,
            apiHeaders: await const GoogleApiHeaders().getHeaders());
        String placeId = p.placeId ?? '0';
        final detail = await plist.getDetailsByPlaceId(placeId);
        address = detail.result.formattedAddress;
        print(detail.result.formattedAddress);
        final geometry = detail.result.geometry!;
        print(geometry);

        final lat = geometry.location.lat;
        final long = geometry.location.lng;

        var newLatLong = LatLng(lat, long);
        print(newLatLong);
      }
      return address!;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }
}
