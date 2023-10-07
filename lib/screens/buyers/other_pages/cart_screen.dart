import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:map_commerce/provider/cart._provider.dart';
import 'package:map_commerce/screens/buyers/other_pages/order_page.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("CheckOut Screen"),
        centerTitle: true,
        actions: [
          IconButton(
              tooltip: "Delete All",
              onPressed: () {
                cart.removeAllProductsFromCart();
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: Consumer(builder: (context, cartProvider, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: cart.cartList.length,
              itemBuilder: (context, index) {
                final prod = cart.cartList[index];

                return Slidable(
                  endActionPane:
                      ActionPane(motion: const BehindMotion(), children: [
                    SlidableAction(
                      onPressed: (context) {
                        cart.removeProductFromCart(prod);
                      },
                      spacing: 0,
                      backgroundColor: Colors.amber[100]!,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ]),
                  child: Card(
                    color: Colors.amber[100],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 35,
                                  backgroundImage:
                                      NetworkImage(prod.product.imageUrl),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      prod.product.name,
                                      style: const TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "\$${prod.quantity * prod.product.amount}",
                                      style: const TextStyle(fontSize: 20),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: Colors.purple[50],
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(100)),
                                child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      // cart.decrease(prod);
                                      cart.decreaseProductQuantity(prod);
                                      setState(() {});
                                    },
                                    icon: Icon(Icons.remove)),
                              ),
                              Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Text(
                                  prod.quantity.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: Colors.greenAccent,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(100)),
                                child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      // cart.increaseProdroductQTy(prod);
                                      cart.increaseProductQuantity(prod);
                                      setState(() {});
                                    },
                                    icon: Icon(Icons.add)),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        );
      }),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "\$${cart.getTotalPrice()}",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // SizedBox(
            //   width: 10,
            // ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(minimumSize: const Size(230, 60)),
              onPressed: () {},
              label: const Text("Check Out"),
              icon: const Icon(Icons.check_circle),
            )
          ],
        )
      ],
    );
  }
}
