// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'package:flutter/foundation.dart';
import 'package:map_commerce/models/cart_model.dart';
import 'package:collection/collection.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> _cartList = [];

  List<CartItem> get cartList => _cartList;

//not working
  addProductToCart(CartItem item) {
    // var inCart = _cartList.contains(item);
    var test = _cartList
        .firstWhereOrNull((element) => element.product.id == item.product.id);
    test is CartItem ? increaseProdroductQTy(item) : addProdroduct(item);
  }

  addProdroduct(CartItem item) {
    _cartList.add(item);
    notifyListeners();
  }

  //not listening from cart
  increaseProdroductQTy(CartItem item) {
    _cartList = _cartList
        .map((CartItem e) => e.product.id == item.product.id ? e.quantity++ : e)
        .toList() as List<CartItem>;
    notifyListeners();
  }

//not listening from cart until refresh
  decrease(CartItem item) {
    _cartList = _cartList
        .map((CartItem e) => e.product.id == item.product.id ? e.quantity-- : e)
        .toList() as List<CartItem>;
    notifyListeners();
  }

  removeProductFromCart(CartItem item) {
    _cartList.removeWhere((itm) => itm.product.id == item.product.id);
    notifyListeners();
    print(_cartList);
  }

  removeAllProductsFromCart() {
    _cartList.clear();
    notifyListeners();
  }

  double getTotalPrice() {
    double total = 0.0;
    for (var item in _cartList) {
      total += item.product.amount * item.quantity;
      print(total);
    }
    return total;
  }

  increaseProductQuantity(CartItem item) {
    if (item.quantity < item.product.availableQuantity) {
      item.quantity++;
      print(item.quantity);
    }
    notifyListeners();
  }

//done
  decreaseProductQuantity(CartItem item) {
    // int theQuantity = _cartList
    //     .firstWhereOrNull(
    //       (itm) => itm.product == item.product,
    //     )!
    //     .quantity;
    if (item.quantity != 1) {
      item.quantity--;
      print(item.quantity);
    }
    notifyListeners();
  }
}
