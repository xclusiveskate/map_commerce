import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:map_commerce/models/product.dart';

class OrderModel {
  final String id;
  final Product product;
  final String userId;
  final DateTime dateOfOrder;
  final String deliveryAddress;
  final String nearbyDeliveryAddress;
  final int contactInfo;
  final int quantity;
  final int totalAmount;
  final DateTime? dateDelivered;
  final bool isDelivered;
  OrderModel({
    required this.id,
    required this.product,
    required this.userId,
    required this.dateOfOrder,
    required this.deliveryAddress,
    required this.nearbyDeliveryAddress,
    required this.contactInfo,
    required this.quantity,
    required this.totalAmount,
    required this.dateDelivered,
    required this.isDelivered,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': product,
      'userId': userId,
      'dateOfOrder': dateOfOrder.toIso8601String(),
      'deliveryAddress': deliveryAddress,
      'nearbyDeliveryAddress': nearbyDeliveryAddress,
      'contactInfo': contactInfo,
      'quantity': quantity,
      'totalAmount': totalAmount,
      'dateDelivered': dateDelivered,
      'isDelivered': isDelivered
    };
  }

  factory OrderModel.fromFirestore(DocumentSnapshot documents) {
    final data = documents.data() as Map;
    return OrderModel(
        id: data['id'] as String,
        product: data['product'] as Product,
        userId: data['userId'] as String,
        dateOfOrder: DateTime.parse(data['dateOfOrder']),
        deliveryAddress: data['deliveryAddress'] as String,
        nearbyDeliveryAddress: data['nearbyDeliveryAddress'] as String,
        contactInfo: data['contactInfo'] as int,
        quantity: data['quantity'],
        totalAmount: data['totalAmount'] as int,
        dateDelivered: data['dateDelivered'] != null
            ? DateTime.parse(data['dateDelivered'])
            : null,
        isDelivered: data['isDelivered'] as bool);
  }

  OrderModel copyWith({
    String? id,
    String? productId,
    String? userId,
    String? deliveryAddress,
    String? nearbyDeliveryAddress,
    DateTime? dateOfOrder,
    DateTime? dateDelivered,
  }) {
    return OrderModel(
        id: id ?? this.id,
        product: product,
        userId: userId ?? this.userId,
        dateOfOrder: dateOfOrder ?? this.dateOfOrder,
        deliveryAddress: deliveryAddress ?? this.deliveryAddress,
        nearbyDeliveryAddress:
            nearbyDeliveryAddress ?? this.nearbyDeliveryAddress,
        contactInfo: contactInfo,
        quantity: quantity,
        totalAmount: totalAmount,
        dateDelivered: dateDelivered ?? this.dateDelivered,
        isDelivered: isDelivered);
  }
}
