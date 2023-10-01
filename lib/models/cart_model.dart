import 'package:map_commerce/models/product.dart';

class CartItem {
  Product product;
  int quantity;
  CartItem({
    required this.product,
    this.quantity = 1,
  });

  CartItem copyWith({
    Product? product,
    int? quantity,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product.toMap(),
      'quantity': quantity,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      product: Product.fromMap(map['product'] as Map<String, dynamic>),
      quantity: map['quantity'] as int,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory CartItem.fromJson(String source) =>
  //     CartItem.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // String toString() => 'CartItem(product: $product, quantity: $quantity)';

  // @override
  // bool operator ==(covariant CartItem other) {
  //   if (identical(this, other)) return true;

  //   return other.product == product && other.quantity == quantity;
  // }

  // @override
  // int get hashCode => product.hashCode ^ quantity.hashCode;
}
