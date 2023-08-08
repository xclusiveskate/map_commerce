import 'package:flutter/material.dart';
import 'package:map_commerce/screens/sellers/nav_pages/oder_history.dart';
import 'package:map_commerce/screens/sellers/nav_pages/account.dart';
import 'package:map_commerce/screens/sellers/nav_pages/buyers.dart';
import 'package:map_commerce/screens/sellers/nav_pages/home.dart';

class SellerMainScreen extends StatefulWidget {
  const SellerMainScreen({super.key});

  @override
  State<SellerMainScreen> createState() => _SellerMainScreenState();
}

class _SellerMainScreenState extends State<SellerMainScreen> {
  int currentIndex = 0;
  List pagess = [
    const SellerHomeScreen(),
    const SellerUsersScreen(),
    const SellerTransactionHistoryScreen(),
    const ShopProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pagess[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            currentIndex = value;
            setState(() {});
          },
          unselectedItemColor: Colors.black.withOpacity(0.3),
          selectedItemColor: Colors.blue,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: "Buyers"),
            BottomNavigationBarItem(
                icon: Icon(Icons.production_quantity_limits_sharp),
                label: "Orders"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
          ]),
    );
  }
}
