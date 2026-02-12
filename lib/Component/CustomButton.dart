import 'package:flutter/material.dart';
import 'package:shyal/const.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
  });
  final String title;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: green_color,
        minimumSize:
            Size(double.infinity, MediaQuery.of(context).size.height * 0.07),
      ),
      onPressed: onPressed,
      child: Text(title, style: const TextStyle(color: Colors.white)),
    );
  }
}
