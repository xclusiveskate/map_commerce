// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';

import 'package:map_commerce/constants/constants.dart';
import 'package:map_commerce/models/payment_status.dart';

class PaymentMethods {
  Future<PaymentResponse> payWithFlutterWave(
      {required BuildContext context,
      required String email,
      required String amount}) async {
    Customer customer = Customer(email: email);

    Flutterwave flutterwave = Flutterwave(
      context: context,
      publicKey: flutterwavePublicApiKey,
      txRef: DateTime.now().toIso8601String(),
      amount: amount,
      customer: customer,
      paymentOptions: 'card, ussd',
      customization: Customization(title: "e-commerce store"),
      redirectUrl: '/',
      isTestMode: true,
      currency: 'USD',
    );

    ChargeResponse response = await flutterwave.charge();

    if (response.status != null && response.success == true) {
      String ref = response.transactionId!;
      return PaymentResponse(status: true, ref: ref);
    } else {
      return PaymentResponse(status: false, ref: '');
    }
  }
}

PaymentMethods paymentMethod = PaymentMethods();
