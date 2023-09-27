import 'package:flutter/foundation.dart';
import 'package:map_commerce/models/cart_model.dart';

class CartProvider extends ChangeNotifier {
  int totalPrice = 0;
  int _quantity = 0;
  final List<CartItem> _cartList = [];

  List<CartItem> get cartList => _cartList;

  int get quantity => _quantity;

//not working
  addProductToCart(CartItem item) {
    if (item.quantity > 0) {
      _cartList.add(item);
      notifyListeners();
    }
  }

//not working
  removeProductFromCart(CartItem item) {
    _cartList.remove(item);
    notifyListeners();
  }

//working
  removeAllProductsFromCart(List<CartItem> list) {
    _cartList.clear();
    notifyListeners();
  }

  increaseProductQuantity(CartItem item) {
    if (item.quantity <= item.product.availableQuantity) {
      notifyListeners();
      item.quantity++;
      print(item.quantity);
    }
    notifyListeners();
  }

  decreaseProductQuantity(CartItem item) {
    if (item.quantity != 0) {
      notifyListeners();
      item.quantity--;
      print(item.quantity);
    }
    notifyListeners();
  }
}
