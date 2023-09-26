import 'package:flutter/material.dart';
import 'package:map_commerce/provider/cart._provider.dart';
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
                cart.removeAllProductsFromCart(cart.cartList);
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: cart.cartList.length,
              itemBuilder: (context, index) {
                final prod = cart.cartList[index];

                return ListTile(
                  title: Text(prod.name),
                  trailing: IconButton(
                      onPressed: () {
                        cart.removeProductFromCart(prod);
                      },
                      icon: const Icon(Icons.delete)),
                );
              })
        ],
      ),
      persistentFooterButtons: const [],
    );
  }
}
