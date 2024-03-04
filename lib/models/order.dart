// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:map_commerce/models/cart_model.dart';
import 'package:map_commerce/models/product.dart';

class OrderModel {
  final String id;
  final List<CartItem> items;
  final String userId;
  final DateTime dateOfOrder;
  final String deliveryAddress;
  final String nearbyDeliveryAddress;
  final int contactInfo;
  // final int quantity;
  final double totalAmount;
  final String paymentId;
  final DateTime? dateDelivered;
  final bool isDelivered;
  OrderModel({
    required this.id,
    required this.items,
    required this.userId,
    required this.dateOfOrder,
    required this.deliveryAddress,
    required this.nearbyDeliveryAddress,
    required this.contactInfo,
    // required this.quantity,
    required this.totalAmount,
    required this.paymentId,
    required this.dateDelivered,
    required this.isDelivered,
  });

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'id': id,
      'items': items.map((x) => x.toFirestore()).toList(),
      'userId': userId,
      'dateOfOrder': dateOfOrder.millisecondsSinceEpoch,
      'deliveryAddress': deliveryAddress,
      'nearbyDeliveryAddress': nearbyDeliveryAddress,
      'contactInfo': contactInfo,
      // 'quantity': quantity,
      'totalAmount': totalAmount,
      'paymentId': paymentId,
      'dateDelivered': dateDelivered?.millisecondsSinceEpoch,
      'isDelivered': isDelivered,
    };
  }

  factory OrderModel.fromFirestore(DocumentSnapshot documents) {
    final data = documents.data() as Map;
    return OrderModel(
      id: data['id'] as String,
      items: List<CartItem>.from(
        (data['items'] as List<int>).map<CartItem>(
          (x) => CartItem.fromFirestore(x as DocumentSnapshot),
        ),
      ),
      userId: data['userId'] as String,
      dateOfOrder:
          DateTime.fromMillisecondsSinceEpoch(data['dateOfOrder'] as int),
      deliveryAddress: data['deliveryAddress'] as String,
      nearbyDeliveryAddress: data['nearbyDeliveryAddress'] as String,
      contactInfo: data['contactInfo'] as int,
      // quantity: data['quantity'] as int,
      totalAmount: data['totalAmount'] as double,
      paymentId: data['paymentId'] as String,
      dateDelivered: data['dateDelivered'] != null
          ? DateTime.fromMillisecondsSinceEpoch(data['dateDelivered'] as int)
          : null,
      isDelivered: data['isDelivered'] as bool,
    );
  }
}
