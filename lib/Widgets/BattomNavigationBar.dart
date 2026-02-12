import 'package:flutter/material.dart';
import 'package:shyal/Screens/HomeScreen.dart';
import 'package:shyal/Screens/InventoryOrder.dart';
import 'package:shyal/Screens/OrderHistoryScreen.dart';
import 'package:shyal/Screens/ProfileScreen.dart';
import 'package:shyal/const.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0; // State to track the selected index

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Navigate based on index
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SenderInventoryOrder()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const OrderHistoryScreen(),
          ),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProfileScreen(),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final iconSize = screenWidth * 0.07;

    return BottomAppBar(
      color: const Color(0xff1D2623),
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: kBottomNavigationBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              iconSize: iconSize,
              icon: const Icon(Icons.home_outlined),
              color: _selectedIndex == 0 ? green_color : Colors.grey,
              onPressed: () => _onItemTapped(0),
            ),
            IconButton(
              iconSize: iconSize,
              icon: const Icon(Icons.layers_outlined),
              color: _selectedIndex == 1 ? green_color : Colors.grey,
              onPressed: () => _onItemTapped(1),
            ),
            const SizedBox(width: 48),
            IconButton(
              iconSize: iconSize,
              icon: const Icon(Icons.notifications_none),
              color: _selectedIndex == 2 ? green_color : Colors.grey,
              onPressed: () => _onItemTapped(2),
            ),
            IconButton(
              iconSize: iconSize,
              icon: const Icon(Icons.settings_outlined),
              color: _selectedIndex == 3 ? green_color : Colors.grey,
              onPressed: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }
}
