import 'package:flutter/foundation.dart';
import 'package:map_commerce/models/cart_model.dart';
import 'package:map_commerce/models/product.dart';

class CartProvider extends ChangeNotifier {
  int totalPrice = 0;
  final List<Product> _cartList = [];

  List<Product> get cartList => _cartList;

  addProductToCart(Product product) {
    _cartList.add(product);
    notifyListeners();
  }

  removeProductFromCart(Product product) {
    _cartList.removeWhere((element) => element.id == product.id);
    notifyListeners();
  }

  removeAllProductsFromCart(List<CartItem> list) {
    _cartList.clear();
    notifyListeners();
  }

  increaseProductQuantity(CartItem item) {
    if (quantity == widget.product.availableQuantity) {
      return null;
    } else {
      setState(() {
        quantity++;
        total = widget.product.amount * quantity;
      });
    }
  }

  decreaseProductQuantity(CartItem item) {
    if (quantity == 0) {
      return null;
    } else {
      setState(() {
        quantity--;
        total = total - widget.product.amount;
      });
    }
  }
}
