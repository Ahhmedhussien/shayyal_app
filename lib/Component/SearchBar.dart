import 'package:flutter/material.dart';
import 'package:shyal/const.dart';

class searchbar extends StatelessWidget {
  const searchbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        decoration: const InputDecoration(
          hintText: 'Search here...',
          hintStyle: TextStyle(color: Colors.black),
          border: InputBorder.none,
          icon: Icon(Icons.search, color: green_color),
          suffixIcon: Icon(
            Icons.close,
            color: green_color,
          ),
        ),
      ),
    );
  }
}
