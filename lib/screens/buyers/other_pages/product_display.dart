import 'package:flutter/material.dart';
import 'package:map_commerce/models/cart_model.dart';

import 'package:map_commerce/models/product.dart';
import 'package:map_commerce/provider/cart._provider.dart';
import 'package:map_commerce/screens/buyers/other_pages/cart_screen.dart';

import 'package:map_commerce/screens/buyers/other_pages/order_page.dart';
import 'package:map_commerce/utils/snackbar.dart';
import 'package:provider/provider.dart';

// import 'package:map_commerce/models/product.dart';

class ProductDisplay extends StatefulWidget {
  final Product product;

  const ProductDisplay({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDisplay> createState() => _ProductDisplayState();
}

class _ProductDisplayState extends State<ProductDisplay> {
  int quantity = 1;
  int total = 0;
  @override
  void initState() {
    super.initState();
    total = widget.product.amount * quantity;
  }

  decrease() {
    if (quantity > 1) {
      quantity--;
      total = widget.product.amount * quantity;
      setState(() {});
    }
  }

  increase() {
    if (quantity < widget.product.availableQuantity) {
      quantity++;
      total = widget.product.amount * quantity;
      setState(() {});
    }
  }

  // continueButton() {
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => OrderPage(
  //                 quantity: quantity,
  //                 total: total,
  //                 product: widget.product,
  //               )));
  // }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    // final quantity = cart.cartList
    //     .firstWhere((item) => item.product == widget.product,
    //         orElse: () => CartItem(product: widget.product, quantity: 0))
    //     .quantity;

    // bool isAdded =
    //     cart.cartList.any((element) => element.product == widget.product);
    // print(isAdded);

    bool itContains =
        cart.cartList.any((element) => element.product.id == widget.product.id);

    return Scaffold(
        appBar: AppBar(
          actions: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(10)),
                        child: IconButton(
                            onPressed: () {
                              // await Authentication.signOut();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const CartPage()));
                            },
                            icon: const Icon(
                              Icons.production_quantity_limits,
                              color: Colors.white70,
                            )),
                      )),
                ),
                Positioned(
                  left: 30,
                  top: 0,
                  child: Container(
                    // width: 25,
                    // height: 25,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // borderRadius: BorderRadius.circular(100),
                        color: Colors.green[100]),
                    child: Center(
                      child: Text(
                        cart.cartList.length.toString(),
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        // isLiked = !isLiked;
                      });
                    },
                    icon: const Icon(
                      Icons.favorite_border,
                      color: Colors.grey,
                    )),
              ),
              Text(
                widget.product.name,
                style:
                    const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "* * * * * ",
                    style: TextStyle(color: Colors.amber, fontSize: 20),
                  ),
                  Text(
                    "(4.5)",
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
              SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width / 2,
                child: Image.network(widget.product.imageUrl),
              ),
              // CarouselSlider.builder(
              //   carouselController: controller,
              //   itemCount: widget.theProduct.image.length,
              //   itemBuilder: (context, index, realIndex) {
              //     final curImage = widget.theProduct.image[index];
              //     return Container(
              //       margin: const EdgeInsets.symmetric(
              //           horizontal: 10.0, vertical: 8.0),
              //       child: Image.asset(
              //         curImage,
              //         fit: BoxFit.contain,
              //       ),
              //     );
              //   },
              //   options: CarouselOptions(
              //       viewportFraction: 1 / 1.6,
              //       pageSnapping: false,
              //       autoPlayInterval: const Duration(seconds: 3),
              //       height: 250,
              //       autoPlay: false,
              //       onPageChanged: ((index, reason) {
              //         setState(() {
              //           currentIndex = index;
              //         });
              //       })),
              // ),
              // AnimatedSmoothIndicator(
              //   activeIndex: currentIndex,
              //   count: widget.theProduct.image.length,
              //   effect: const ScrollingDotsEffect(
              //       activeStrokeWidth: 2,
              //       activeDotColor: Colors.amber,
              //       dotColor: Colors.grey,
              //       dotWidth: 16,
              //       dotHeight: 6),
              //   onDotClicked: (index) {
              //     controller.animateToPage(index);
              //   },
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.amber,
                          ),
                          child: IconButton(
                              onPressed: decrease,
                              icon: const Icon(Icons.remove))),
                    ),
                    Text(
                      quantity.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.amber,
                          ),
                          child: IconButton(
                              onPressed: increase,
                              icon: const Icon(Icons.add))),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Available Quantity: ${widget.product.availableQuantity} pieces",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w300),
                      ),
                      const Text(
                        textAlign: TextAlign.start,
                        "Description",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.product.description,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Total Price"),
                        Text(
                          '\$ ${total.toString()}',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.amber),
                            minimumSize: MaterialStateProperty.all(Size(
                                MediaQuery.of(context).size.width / 1.8, 40))),
                        onPressed: () async {
                          cart.addProductToCart(
                              context, CartItem(product: widget.product));
                          if (itContains) {
                            showSnack(
                                context: context, message: 'product added');
                            print(itContains);
                          } else {
                            print(itContains);
                            await showDialog(
                                context: context,
                                barrierDismissible: false,
                                barrierColor: Colors.amber.withOpacity(0.1),
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Product added to cart"),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Ok!!!"))
                                    ],
                                  );
                                });
                          }
                        },
                        child: const Text(
                          "Add to Cart",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
