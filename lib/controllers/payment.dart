// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';

import 'package:map_commerce/constants/constants.dart';
import 'package:map_commerce/models/payment_status.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

class PaymentMethods {
  final plugin = PaystackPlugin();

  PaymentMethods() {
    plugin.initialize(publicKey: PAYSTACK_PUBLIC_KEY);
  }

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

  Future<PaymentResponse> payWithPaystack(
      {required BuildContext context,
      required double amount,
      required String email}) async {
    await Future.delayed(const Duration(seconds: 2));
    Charge charge = Charge()
      ..amount = (amount * 100).toInt()
      ..currency = "NGN"
      ..email = email
      ..reference = DateTime.now().toIso8601String();
    if (context.mounted) {
      CheckoutResponse res = await plugin.checkout(context,
          charge: charge, method: CheckoutMethod.card);

      if (res.status && res.reference != null) {
        final reference = res.reference!;

        return PaymentResponse(status: res.status, ref: reference);
      } else {
        return PaymentResponse.initial();
      }
    } else {
      return PaymentResponse.initial();
    }
  }
}

PaymentMethods paymentMethod = PaymentMethods();
