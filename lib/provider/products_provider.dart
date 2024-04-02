import 'package:flutter/material.dart';
import 'package:map_commerce/models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  updateListOfProduct(List<Product> newList) {
    _products = newList;
    notifyListeners();
  }
}
