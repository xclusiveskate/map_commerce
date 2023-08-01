import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:map_commerce/screens/auth/sign_in.dart';
import 'package:map_commerce/screens/buyers/buyer.dart';
import 'package:map_commerce/screens/sellers/seller.dart';
import '../../local_storage/check_admin.dart';

class CheckIfUserActive extends StatefulWidget {
  final User? user;
  const CheckIfUserActive({super.key, this.user});
  @override
  State<CheckIfUserActive> createState() => _CheckIfUserActiveState();
}

class _CheckIfUserActiveState extends State<CheckIfUserActive> {
  // User? user;
  // // bool signedIn = false;
  // final auth = FirebaseAuth.instance;
  // checkUser() async {
  //   final theUser = auth.currentUser;
  //   if (theUser != null) {
  //     setState(() {
  //       user = theUser;
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    getStatus();
  }

  getStatus() async {
    final returnedValue = await SaveToLocal.getBool();
    setState(() {
      isAdmin = returnedValue;
    });
    print("The returned value is:  $returnedValue");
  }

  @override
  Widget build(BuildContext context) {
    return widget.user != null
        ? isAdmin!
            ? const SellerMainScreen()
            : const MainScreen()
        : const AuthScreen();
  }
}
