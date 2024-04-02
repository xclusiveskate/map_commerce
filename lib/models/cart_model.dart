import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:map_commerce/models/product_model.dart';

class CartItem {
  Product product;
  int quantity;
  CartItem({
    required this.product,
    this.quantity = 1,
  });

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'product': product.toFirestore(),
      'quantity': quantity,
    };
  }

  factory CartItem.fromFirestore(DocumentSnapshot document) {
    final data = document.data() as Map;
    return CartItem(
      product:
          Product.fromFirestore(data['product'] as DocumentSnapshot<Object?>),
      quantity: data['quantity'] as int,
    );
  }
}
