import 'package:flutter/foundation.dart';
import 'package:map_commerce/models/product.dart';

class CartProvider extends ChangeNotifier {
  List<Product> _cartList = [];

  get cartList => _cartList;

  addProductToCart(Product product) {
    _cartList.add(product);
    notifyListeners();
  }

  removeProductFromCart(Product product) {
    _cartList.removeWhere((element) => element.id == product.id);
    notifyListeners();
  }

  removeAllProductsFromCart(List<Product> list) {
    _cartList.clear();
    notifyListeners();
  }
}
