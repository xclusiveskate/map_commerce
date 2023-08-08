import 'package:flutter/material.dart';
import 'package:map_commerce/widgets/history.dart';

class SellerTransactionHistoryScreen extends StatefulWidget {
  const SellerTransactionHistoryScreen({super.key});

  @override
  State<SellerTransactionHistoryScreen> createState() =>
      _SellerTransactionHistoryScreenState();
}

class _SellerTransactionHistoryScreenState
    extends State<SellerTransactionHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return const OrdersScreen();
  }
}
