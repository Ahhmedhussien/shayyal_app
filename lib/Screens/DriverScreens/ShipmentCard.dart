import 'package:flutter/material.dart';
import 'package:shyal/const.dart';

class ShipmentCard extends StatelessWidget {
  final Color iconColor;
  final String productName;
  final String productId;

  ShipmentCard({
    required this.iconColor,
    required this.productName,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Secound_background_color,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.local_shipping, color: iconColor),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'ID: $productId',
                    style: TextStyle(
                      color: Color(0xFFD9D9D9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
