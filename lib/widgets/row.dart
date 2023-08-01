import 'package:flutter/material.dart';

class MyRow extends StatelessWidget {
  final Widget firstIcon;
  final Widget secondIcon;

  const MyRow({
    super.key,
    required this.firstIcon,
    required this.secondIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.amber,
            ),
            child: firstIcon),
        Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.amber,
            ),
            child: secondIcon),
      ],
    );
  }
}
