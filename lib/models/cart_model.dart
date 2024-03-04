import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:map_commerce/models/product.dart';

class CartItem {
  Product product;
  int quantity;
  CartItem({
    required this.product,
    this.quantity = 1,
  });

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'product': product.toMap(),
      'quantity': quantity,
    };
  }

  factory CartItem.fromFirestore(DocumentSnapshot document) {
    final data = document.data() as Map;
    return CartItem(
      product: Product.fromMap(data['product'] as Map<String, dynamic>),
      quantity: data['quantity'] as int,
    );
  }
}
