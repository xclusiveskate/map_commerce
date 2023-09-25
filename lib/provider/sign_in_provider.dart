import 'package:flutter/material.dart';
import 'package:map_commerce/controllers/auth.dart';

class AuthProvider extends ChangeNotifier {
  static bool _isLoading = false;

  get isLaoding => _isLoading;

  signInAdmin(BuildContext, context, email, String password) async {
    _isLoading = true;
    notifyListeners();
    Authentication.signInAdminWithEmail(
        context: context, email: email, password: password);
    await Future.delayed(const Duration(seconds: 5), () {});
    _isLoading = false;
    notifyListeners();
  }

  signInUser(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    Authentication.signUserUpWithGoogle(context);
    await Future.delayed(const Duration(seconds: 5), () {});
    _isLoading = false;
    notifyListeners();
  }
}
