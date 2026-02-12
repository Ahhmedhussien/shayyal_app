import 'package:flutter/material.dart';

// ignore: camel_case_types
class Icon_BackGrounded extends StatelessWidget {
  const Icon_BackGrounded({
    super.key,
    required this.iconContainerSize,
    required this.icon,
    required this.color,
  });

  final Icon icon;
  final Color color;
  final double iconContainerSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: iconContainerSize,
      width: iconContainerSize,
      padding: EdgeInsets.all(iconContainerSize * 0.2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: icon,
      // color: green_color
    );
  }
}
