// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:map_commerce/models/cart_model.dart';
import 'package:collection/collection.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> _cartList = [];

  List<CartItem> get cartList => _cartList;

  addProductToCart(BuildContext context, CartItem item) {
    var test = _cartList
        .firstWhereOrNull((element) => element.product.id == item.product.id);
    test is CartItem
        ? increaseProductQTy(context, item)
        : addProduct(context, item);
    return test;
  }

  addProduct(BuildContext context, CartItem item) async {
    _cartList.add(item);
    notifyListeners();
    // final cont = context.watch<AuthProvider>();
    // print(cont.userId);

    // await FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(cont.userId)
    //     .update({
    //   'cart': FieldValue.arrayUnion([item.toMap()])
    // });
    // notifyListeners();
  }

  //not listening from cart
  increaseProductQTy(BuildContext context, CartItem item) {
    // _cartList = _cartList
    //     .map((CartItem e) => e.product.id == item.product.id ? e.quantity++ : e)
    //     .toList() as List<CartItem>;

    int index = _cartList.indexWhere((e) => e.product.id == item.product.id);
    if (index != -1) {
      _cartList[index].quantity++;
    } else {
      _cartList[index];
    }

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
