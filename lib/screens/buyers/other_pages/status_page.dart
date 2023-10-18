// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:map_commerce/models/payment_status.dart';
import 'package:map_commerce/screens/buyers/buyer.dart';

class PaymentStatusPage extends StatefulWidget {
  PaymentResponse response;
  double amount;
  PaymentStatusPage({
    Key? key,
    required this.response,
    required this.amount,
  }) : super(key: key);

  @override
  State<PaymentStatusPage> createState() => _PaymentStatusPageState();
}

class _PaymentStatusPageState extends State<PaymentStatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                  radius: 35.0,
                  backgroundColor:
                      widget.response.status ? Colors.green : Colors.red,
                  child: widget.response.status
                      ? const Icon(
                          Icons.done_outline_sharp,
                          color: Colors.white,
                        )
                      : const Icon(
                          Icons.sms_failed,
                          color: Colors.white,
                        )),
              widget.response.status
                  ? Text("Your payment of \$${widget.amount} is succeful.")
                  : const Text("Payment failed"),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      minimumSize: const Size(double.infinity, 50)),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainScreen()));
                  },
                  icon: const Icon(Icons.home),
                  label: const Text("Back to Home"))
            ],
          ),
        ),
      ),
    );
  }
}
