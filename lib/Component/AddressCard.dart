import 'package:flutter/material.dart';
import 'package:shyal/const.dart';

class AddressCard extends StatelessWidget {
  final String type;
  final String name;
  final String phone;
  final String address;
  final void Function()? onEdit;
  final void Function()? onDelete;

  const AddressCard(
      {super.key,
      required this.type,
      required this.name,
      required this.phone,
      required this.address,
      required this.onEdit,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        color: Secound_background_color,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(type == 'Home' ? Icons.home : Icons.work,
                      color: green_color),
                  const SizedBox(width: 10),
                  Text(type,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.045,
                      )),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: green_color,
                    ),
                    onPressed: onEdit,
                    iconSize: screenWidth * 0.06,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: onDelete,
                    iconSize: screenWidth * 0.06,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.04,
                  )),
              Text(phone,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.04,
                  )),
              Text(address,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.04,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
