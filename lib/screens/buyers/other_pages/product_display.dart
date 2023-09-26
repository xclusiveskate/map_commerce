import 'package:flutter/material.dart';
import 'package:map_commerce/models/product.dart';
import 'package:map_commerce/provider/cart._provider.dart';
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
  int quantity = 0;
  int total = 0;
  @override
  void initState() {
    super.initState();
  }

  // continueButton() {
  //   if (quantity == 0) {
  //     return null;
  //   } else {
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => OrderPage(
  //                   quantity: quantity,
  //                   total: total,
  //                   product: widget.product,
  //                 )));
  //   }
  // }

  addToCart(Product product) {}

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    bool isAdded = cart.cartList.contains(widget.product);
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
              // IconButton(
              //     onPressed: () {
              //       setState(() {
              //         // isLiked = !isLiked;
              //       });
              //     },
              //     icon: isLiked
              //         ? const Icon(
              //             Icons.favorite_border,
              //             color: Colors.grey,
              //           )
              //         : const Icon(
              //             Icons.favorite,
              //             color: Colors.red,
              //           ))
            ],
          ),
          Text(
            widget.product.name,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
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
                          onPressed: () {
                            // decreaseQuantity();
                          },
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
                          onPressed: () {
                            // increaseQuantity();
                          },
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
                  const Text(
                    textAlign: TextAlign.start,
                    "Description",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                        minimumSize: MaterialStateProperty.all(
                            Size(MediaQuery.of(context).size.width / 1.8, 40))),
                    onPressed: () {
                      if (isAdded == true) {
                        cart.removeProductFromCart(widget.product);
                      } else {
                        cart.addProductToCart(widget.product);
                      }
                    },
                    child: Text(
                      isAdded ? "Remove from Cart" : "Add to Cart",
                      style: const TextStyle(
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
