// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_commerce/constants/constants.dart';
import 'package:map_commerce/controllers/database.dart';
import 'package:map_commerce/models/product.dart';
import 'package:map_commerce/screens/buyers/buyer.dart';
import 'package:google_maps_webservice/places.dart' as serv;
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

      showSnack(
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
                keyboardType: TextInputType.number,
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
