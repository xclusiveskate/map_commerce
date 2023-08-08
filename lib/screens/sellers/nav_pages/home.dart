import 'package:flutter/material.dart';
import 'package:map_commerce/screens/sellers/other_pages/add_product.dart';

import 'package:map_commerce/screens/sellers/tabs/all.dart';
import 'package:map_commerce/widgets/row.dart';

class SellerHomeScreen extends StatefulWidget {
  const SellerHomeScreen({super.key});

  @override
  State<SellerHomeScreen> createState() => _SellerHomeScreenState();
}

class _SellerHomeScreenState extends State<SellerHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController control;

  @override
  void initState() {
    super.initState();
    control = TabController(
        length: 6,
        vsync: this,
        animationDuration: const Duration(milliseconds: 1));
  }

  @override
  void dispose() {
    control.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyRow(
              firstIcon:
                  IconButton(onPressed: () {}, icon: const Icon(Icons.apps)),
              secondIcon: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddProduct()));
                  },
                  icon: const Icon(Icons.add)),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "welcome",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              textAlign: TextAlign.left,
              "BD Shops",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: const Icon(Icons.filter),
                  hintText: "Search Category"),
            ),
            // ignore: avoid_unnecessary_containers
            Container(
              child: TabBar(
                  indicatorColor: Colors.amber,
                  labelPadding: const EdgeInsets.all(16),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  controller: control,
                  isScrollable: true,
                  tabs: const [
                    Text(
                      "All",
                    ),
                    Text("Bags"),
                    Text("Shoes"),
                    Text("Laptops"),
                    Text("Phones"),
                    Text("Accessories"),
                  ]),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: TabBarView(controller: control, children: const [
                All(),
                Text("Bags"),
                Text("Shoes"),
                Text("Laptops"),
                Text("Phones"),
                Text("Accessories"),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
