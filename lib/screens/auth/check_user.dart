import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:map_commerce/provider/admin.change.dart';
import 'package:map_commerce/screens/auth/sign_in.dart';
import 'package:map_commerce/screens/buyers/buyer.dart';
import 'package:map_commerce/screens/sellers/seller.dart';
import 'package:provider/provider.dart';
import '../../local_storage/check_admin.dart';

class CheckIfUserActive extends StatefulWidget {
  final User? user;
  const CheckIfUserActive({super.key, this.user});
  @override
  State<CheckIfUserActive> createState() => _CheckIfUserActiveState();
}

class _CheckIfUserActiveState extends State<CheckIfUserActive> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      getStatus();
    }
  }

  getStatus() async {
    final stat = context.read<AdminChanger>();
    final returnedValue = await SaveToLocal.getBool();
    stat.updateAdminStatus(returnedValue);
    print("The returned value is:  $returnedValue");
  }

  @override
  Widget build(BuildContext context) {
    final status = context.watch<AdminChanger>();
    return widget.user != null
        ? status.isAdmin
            ? const SellerMainScreen()
            : const MainScreen()
        : const AuthScreen();
  }
}
