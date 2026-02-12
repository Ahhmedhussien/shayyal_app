import 'package:flutter/material.dart';
import 'package:shyal/Component/Icon_BackGrounded.dart';
import 'package:shyal/const.dart';

class CustomProfileButton extends StatelessWidget {
  const CustomProfileButton({
    super.key,
    required this.screenSize,
    required this.onTap,
    required this.leftIcon,
    required this.rightIcon,
    required this.title,
  });

  final Size screenSize;
  final VoidCallback onTap;
  final IconData leftIcon;
  final IconData rightIcon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: background_color,
          borderRadius: BorderRadius.circular(8.0),
          border: const Border(
            bottom: BorderSide(color: Colors.grey),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon_BackGrounded(
                    color: background_color,
                    iconContainerSize: screenSize.width * 0.16,
                    icon: Icon(leftIcon)),
                Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: screenSize.width * 0.05))
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: screenSize.width * 0.05),
              child: Icon(rightIcon, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
