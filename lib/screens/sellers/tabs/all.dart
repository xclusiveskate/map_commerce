import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:map_commerce/constants/constants.dart';
import 'package:map_commerce/models/product.dart';
import 'package:map_commerce/screens/buyers/other_pages/product_display.dart';
import '../../../local_storage/check_admin.dart';

class All extends StatefulWidget {
  const All({super.key});

  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> {
  ScrollController scroll = ScrollController();
  // List<Product> products = [];
  Stream<QuerySnapshot<Object?>> productStream =
      FirebaseFirestore.instance.collection('products').snapshots();
  // late bool isAdmin;
  // getStatus() async {
  //   final status = await SaveToLocal.getBool();
  //   setState(() {
  //     isAdmin = status;
  //   });
  //   print(status);
  // }

  @override
  void initState() {
    super.initState();
    // getStatus();
  }

  @override
  Widget build(BuildContext context) {
    // final check = context.watch<Admin>();
    return StreamBuilder<QuerySnapshot<Object?>>(
        stream: productStream,
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox.shrink();
          } else if (snapshot.hasError) {
            return const Center(child: Text('Unable to load data'));
          } else {
            final List<QueryDocumentSnapshot<Object?>> gottenProducts =
                snapshot.data!.docs;
            // print(gottenProducts);
            List<Product> products = gottenProducts
                .map((doc) => Product.fromFirestore(doc))
                .toList();
            theProducts = products;

            return GridView.builder(
                padding: const EdgeInsets.all(8),
                primary: false,
                shrinkWrap: true,
                // scrollDirection: Axis.vertical,
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20.0,
                    crossAxisSpacing: 15.0,
                    childAspectRatio: 2 / 2.6),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Container(
                    child: InkWell(
                      onTap: () {
                        isAdmin!
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
                                    height: 25,
                                    width: 25,
                                    decoration: const BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            bottomLeft: Radius.circular(5))),
                                    child: product.availableQuantity == 0
                                        ? const Icon(
                                            Icons.lock,
                                            color: Colors.white,
                                            size: 15,
                                          )
                                        : Text(
                                            textAlign: TextAlign.center,
                                            product.availableQuantity
                                                .toString()),
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
