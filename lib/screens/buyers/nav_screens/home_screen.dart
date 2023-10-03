import 'package:flutter/material.dart';
import 'package:map_commerce/screens/sellers/tabs/all.dart';
import 'package:map_commerce/widgets/row.dart';

import '../other_pages/cart_screen.dart';

class BuyerHomeScreen extends StatefulWidget {
  const BuyerHomeScreen({super.key});

  @override
  State<BuyerHomeScreen> createState() => _BuyerHomeScreenState();
}

class _BuyerHomeScreenState extends State<BuyerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 8.0, vertical: MediaQuery.of(context).size.height / 15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            MyRow(
              firstIcon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.apps),
              ),
              secondIcon: GestureDetector(
                  onTap: () {},
                  child: IconButton(
                      onPressed: () {
                        // await Authentication.signOut();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CartPage()));
                      },
                      icon: const Icon(Icons.production_quantity_limits))),
            ),
            const SizedBox(
              height: 20,
            ),
            SearchBar(
              hintText: "search product",
              leading: const Icon(Icons.search),
              elevation: MaterialStateProperty.all(0.5),
            ),
            const SizedBox(
              height: 20,
            ),
            const All()
          ],
        ),
      ),
    );
  }
}
