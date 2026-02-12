import 'package:flutter/material.dart';
import 'package:shyal/LogServes.dart';
import 'package:shyal/Models/DriverModels/DriverOrders.dart';
import 'package:shyal/Services/LocationService.dart';
import 'package:shyal/const.dart';

class OrderCard extends StatefulWidget {
  final DriverOrder order;
  final void Function() onPressedApprove;
  final void Function() onPressedDecline;

  const OrderCard({
    super.key,
    required this.order,
    required this.onPressedApprove,
    required this.onPressedDecline,
  });

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  // LocationService _locationService = LocationService();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Secound_background_color,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.local_shipping, color: green_color),
                  const SizedBox(width: 10),
                  Text(
                    widget.order.description,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Description: ${widget.order.description}',
                style: const TextStyle(
                  color: Color(0xFFD9D9D9),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'From: ${widget.order.senderAddress}',
                style: const TextStyle(
                  color: Color(0xFFD9D9D9),
                  fontSize: 18,
                ),
              ),
              Text(
                'To: ${widget.order.receiverAddress}',
                style: const TextStyle(
                  color: Color(0xFFD9D9D9),
                  fontSize: 18,
                ),
              ),
              Text(
                'Price: ${widget.order.totalCost} \$',
                style: const TextStyle(
                  color: Color(0xFFD9D9D9),
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: widget.onPressedApprove,
                    style: TextButton.styleFrom(
                      backgroundColor: Secound_background_color,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Approve'),
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: widget.onPressedDecline,
                    style: TextButton.styleFrom(
                      backgroundColor: Secound_background_color,
                      foregroundColor: green_color,
                    ),
                    child: const Text('Decline'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
