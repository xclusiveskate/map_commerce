// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:map_commerce/models/cart_model.dart';

class UserModel {
  final String? userId;
  final String? displayName;
  final String? email;
  final String? imageUrl;
  List<CartItem> cart;
  UserModel({
    required this.userId,
    required this.displayName,
    required this.email,
    required this.imageUrl,
    this.cart = const [],
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userId': userId,
      'displayName': displayName,
      'email': email,
      'imageUrl': imageUrl,
      'cart': cart.map((x) => x.toMap()).toList(),
    };
  }

  factory UserModel.fromFirestore(DocumentSnapshot document) {
    final data = document.data() as Map;
    return UserModel(
      userId: data['userId'] as String,
      displayName: data['displayName'] as String,
      email: data['email'] as String,
      imageUrl: data['imageUrl'] as String,
      cart: List<CartItem>.from(
        (data['cart'] as List<int>).map<CartItem>(
          (x) => CartItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
