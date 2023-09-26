import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:map_commerce/models/product.dart';
import 'package:map_commerce/provider/admin.change.dart';
import 'package:map_commerce/provider/products.dart';
import 'package:map_commerce/screens/buyers/other_pages/product_display.dart';
import 'package:provider/provider.dart';

class All extends StatefulWidget {
  const All({super.key});

  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> {
  ScrollController scroll = ScrollController();

  Stream<QuerySnapshot<Object?>> productStream =
      FirebaseFirestore.instance.collection('products').snapshots();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final status = context.watch<AdminChanger>();
    final products = context.read<ProductProvider>();
    return StreamBuilder<QuerySnapshot<Object?>>(
        stream: productStream,
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox.shrink();
          } else if (snapshot.hasError) {
            return const Center(child: Text('Unable to load data'));
          } else {
            final List<Product> gottenProducts = (snapshot.data!.docs)
                .map((doc) => Product.fromFirestore(doc))
                .toList();
            // print(gottenProducts);
            // List<Product> products = gottenProducts
            //     .map((doc) => Product.fromFirestore(doc))
            //     .toList();
            // theProducts = products;
            products.updateListOfProduct(gottenProducts);

            final prods = products.products;
            print((prods as List).length);

            return GridView.builder(
                padding: const EdgeInsets.all(8),
                primary: false,
                shrinkWrap: true,
                // scrollDirection: Axis.vertical,
                itemCount: prods.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20.0,
                    crossAxisSpacing: 15.0,
                    childAspectRatio: 2 / 2.6),
                itemBuilder: (context, index) {
                  final product = prods[index];
                  return Container(
                    child: InkWell(
                      onTap: () {
                        status.isAdmin!
                            ? null
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDisplay(
                                          product: product,
                                        )));
                      },
                      child: Container(
                        // color: Colors.blue,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromARGB(255, 224, 224, 224),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  blurStyle: BlurStyle.outer),
                              BoxShadow(
                                  color: Color.fromARGB(255, 224, 224, 224),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  blurStyle: BlurStyle.outer)
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 100,
                              width: 200,
                              child: Image.network(product.imageUrl),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        Text(product.category),
                                        Text("\$${product.amount.toString()}"),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    width: 30,
                                    decoration: const BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            bottomLeft: Radius.circular(5))),
                                    child: Column(
                                      children: [
                                        const Text("Qty"),
                                        product.availableQuantity == 0
                                            ? const Icon(
                                                Icons.lock,
                                                color: Colors.white,
                                                size: 15,
                                              )
                                            : Text(
                                                textAlign: TextAlign.center,
                                                product.availableQuantity
                                                    .toString())
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
        });
  }
}
