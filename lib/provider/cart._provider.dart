import 'package:flutter/foundation.dart';
import 'package:map_commerce/models/cart_model.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> _cartList = [];
  // bool _isAdded = false;

  List<CartItem> get cartList => _cartList;
  // bool get isAdded => _isAdded;

  // bool added(Product item) {
  //   return _cartList.contains(CartItem(product: item));
  // }

//not working
  addProductToCart(CartItem item) {
    var inCart = _cartList.contains(item);

    inCart ? increaseProdroductQTy(item) : addProdroduct(item);
    print(_cartList);

    notifyListeners();
  }

  addProdroduct(CartItem item) {
    _cartList.add(item);
  }

  increaseProdroductQTy(CartItem item) {
    _cartList = _cartList
        .map((CartItem e) => e.product.id == item.product.id ? e.quantity++ : e)
        .toList() as List<CartItem>;
    notifyListeners();
  }

//not working
  removeProductFromCart(CartItem item) {
    _cartList.removeWhere((itm) => itm.product.id == item.product.id);
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
