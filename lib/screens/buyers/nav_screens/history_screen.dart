import 'package:flutter/material.dart';
import 'package:map_commerce/widgets/history.dart';

class BuyerTransactionHistoryScreen extends StatefulWidget {
  const BuyerTransactionHistoryScreen({super.key});

  @override
  State<BuyerTransactionHistoryScreen> createState() =>
      _BuyerTransactionHistoryScreenState();
}

class _BuyerTransactionHistoryScreenState
    extends State<BuyerTransactionHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return const OrdersScreen();
  }
}
