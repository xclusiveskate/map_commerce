import 'package:flutter/material.dart';
import 'package:map_commerce/controllers/auth.dart';
import 'package:map_commerce/screens/sellers/tabs/all.dart';
import 'package:map_commerce/widgets/row.dart';

class BuyerHomeScreen extends StatefulWidget {
  const BuyerHomeScreen({super.key});

  @override
  State<BuyerHomeScreen> createState() => _BuyerHomeScreenState();
}

class _BuyerHomeScreenState extends State<BuyerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 36),
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
                      onPressed: () async {
                        await Authentication.signOut();
                      },
                      icon: const Icon(Icons.logout))),
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
