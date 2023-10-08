import 'package:flutter/material.dart';

showSnack({required BuildContext context, required String message}) {
  return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 1)));
}
