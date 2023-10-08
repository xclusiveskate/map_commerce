// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:map_commerce/models/cart_model.dart';
import 'package:collection/collection.dart';
import 'package:map_commerce/utils/snackbar.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> _cartList = [];

  List<CartItem> get cartList => _cartList;

  addProductToCart(BuildContext context, CartItem item) {
    // var inCart = _cartList.contains(item);
    var test = _cartList
        .firstWhereOrNull((element) => element.product.id == item.product.id);
    test is CartItem ? increaseProductQTy(context, item) : addProdroduct(item);
    return test;
  }

  addProdroduct(CartItem item) {
    _cartList.add(item);
    notifyListeners();
  }

  //not listening from cart
  increaseProductQTy(BuildContext context, CartItem item) {
    _cartList = _cartList
        .map((CartItem e) => e.product.id == item.product.id ? e.quantity++ : e)
        .toList() as List<CartItem>;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("product added")));
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

  increaseProductQuantity(CartItem item) {
    if (item.quantity < item.product.availableQuantity) {
      item.quantity++;
      print(item.quantity);
    }
    notifyListeners();
  }

  decreaseProductQuantity(CartItem item) {
    if (item.quantity != 1) {
      item.quantity--;
      print(item.quantity);
    }
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
}
