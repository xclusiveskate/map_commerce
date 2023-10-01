import 'package:flutter/foundation.dart';
import 'package:map_commerce/models/cart_model.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartList = [];
  // bool _isAdded = false;

  List<CartItem> get cartList => _cartList;
  // bool get isAdded => _isAdded;

  // bool added(Product item) {
  //   return _cartList.contains(CartItem(product: item));
  // }

//not working
  addProductToCart(CartItem item) {
    _cartList.add(item);
    notifyListeners();
    print(_cartList);
  }

//not working
  removeProductFromCart(CartItem item) {
    _cartList.remove(item);
    notifyListeners();
    print(_cartList);
  }

//working
  removeAllProductsFromCart(List<CartItem> list) {
    _cartList.clear();
    notifyListeners();
  }

  // increaseProductQuantity(CartItem item) {
  //   if (item.quantity <= item.product.availableQuantity) {
  //     notifyListeners();
  //     item.quantity++;
  //     print(item.quantity);
  //   }
  //   notifyListeners();
  // }

  // decreaseProductQuantity(Product product, int newQuantity) {
  //   int theQuantity = _cartList
  //       .firstWhere(
  //         (item) => item.product == product,
  //         orElse: () => CartItem(product: product, quantity: 0),
  //       )
  //       .quantity;
  //   if (item.quantity != 0) {
  //     notifyListeners();
  //     item.quantity--;
  //     print(item.quantity);
  //   }
  //   notifyListeners();
  // }
}
