import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:map_commerce/controllers/auth.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  String _userId = '';

  bool get isLaoding => _isLoading;
  String get userId => _userId;

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
    UserCredential res = await Authentication.signUserUpWithGoogle(context);
    _userId = res.user!.uid;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 5), () {});
    _isLoading = false;
    notifyListeners();
  }
}
