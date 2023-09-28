import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double height;
  final double width;
  final ShapeBorder shape;
  const ShimmerWidget.rectangle({
    super.key,
    required this.height,
    required this.width,
    this.shape = const RoundedRectangleBorder(),
  });
  const ShimmerWidget.circle({
    super.key,
    required this.height,
    required this.width,
    this.shape = const CircleBorder(),
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[300]!,
      period: const Duration(seconds: 2),
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(color: Colors.blueGrey, shape: shape),
      ),
    );
  }
}
