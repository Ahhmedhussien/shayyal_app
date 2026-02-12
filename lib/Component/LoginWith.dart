import 'package:flutter/material.dart';

class LoginWith extends StatelessWidget {
  final Widget icon;
  final String lable;
  final void Function() onPressed;

  const LoginWith(
      {super.key,
      required this.icon,
      required this.lable,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: Text(
        lable,
        style: TextStyle(fontSize: screenSize.width * 0.04),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        minimumSize: Size(screenSize.width * 0.4, screenSize.height * 0.055),
      ),
    );
  }
}
