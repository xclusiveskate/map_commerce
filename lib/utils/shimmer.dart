import 'package:flutter/material.dart';
import 'package:map_commerce/widgets/shimmer_widget.dart';

GridView buildLaodingShimmer() {
  return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8.0),
      itemCount: 4,
      primary: false,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 20.0,
          childAspectRatio: 2 / 2.6),
      itemBuilder: (context, index) {
        return Container(
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
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 100,
                width: 200,
                child: ShimmerWidget.rectangle(height: 100, width: 200),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                ShimmerWidget.rectangle(height: 5, width: 60),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                ShimmerWidget.rectangle(height: 5, width: 40),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                ShimmerWidget.rectangle(height: 5, width: 30),
                          ),
                        ],
                      ),
                    ),
                    ShimmerWidget.rectangle(height: 40, width: 30)
                  ],
                ),
              )
            ],
          ),
        );
      });
}
