import 'package:flutter/material.dart';

class AdminChanger extends ChangeNotifier {
  bool _isAdmin = false;

  get isAdmin => _isAdmin;

  updateAdminStatus(bool status) {
    _isAdmin = status;
    notifyListeners();
  }
}
