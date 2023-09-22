import 'package:flutter/material.dart';
import 'package:map_commerce/models/product.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];

  get products => _products;

  updateListOfProduct(List<Product> newList) {
    _products = newList;
    notifyListeners();
  }
}
