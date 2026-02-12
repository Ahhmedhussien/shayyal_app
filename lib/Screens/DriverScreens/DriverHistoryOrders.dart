import 'package:flutter/material.dart';
import 'package:shyal/Screens/DriverScreens/DriverHomePage.dart';
import 'package:shyal/Screens/DriverScreens/DriverSettingsScreen.dart';
import 'package:shyal/Screens/DriverScreens/ShipmentCard.dart';
import 'package:shyal/const.dart';

class DriverHistoryOrders extends StatefulWidget {
  const DriverHistoryOrders({super.key});

  @override
  _DriverHistoryOrdersState createState() => _DriverHistoryOrdersState();
}

class _DriverHistoryOrdersState extends State<DriverHistoryOrders> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";
  List<Map<String, String>> shipments = [
    {
      'productName': 'iPhone 14 pro max 356 G',
      'productId': '13831445450',
      'iconColor': '0xFF5293F5'
    },
    {
      'productName': 'Laptop Dell Vostro 3510 i5 1135G',
      'productId': '13838323233',
      'iconColor': '0xFFF0B9B9'
    },
    {
      'productName': 'Laptop Lenovo Yoga 7 14IAL7 i5...',
      'productId': '1383839292',
      'iconColor': '0xFFF55252'
    },
    {
      'productName': 'MacBook Air 13 inch M1',
      'productId': '1383132292',
      'iconColor': '0xFF5293F5'
    },
    {
      'productName': 'Mic Dx26226',
      'productId': '1588918562',
      'iconColor': '0xFFF58352'
    },
    {
      'productName': 'Smart Watch xm1052',
      'productId': '16512618516',
      'iconColor': '0xFF1D2623'
    },
    {
      'productName': 'SweatPants black XL size',
      'productId': '16518532146',
      'iconColor': '0xFF31333D'
    },
  ];

  List<Map<String, String>> filteredShipments = [];

  @override
  void initState() {
    super.initState();
    filteredShipments = shipments;
  }

  void performSearch() {
    setState(() {
      searchQuery = searchController.text.toLowerCase();
      filteredShipments = shipments
          .where((shipment) =>
              shipment['productName']!.toLowerCase().contains(searchQuery) ||
              shipment['productId']!.toLowerCase().contains(searchQuery))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_color,
      appBar: AppBar(
        backgroundColor: background_color,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Recent Your Shipment',
            style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Secound_background_color,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Enter Receipt number',
                hintStyle: const TextStyle(color: Color(0xFF656565)),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Color(0xFF656565)),
                  onPressed: performSearch,
                ),
              ),
              onSubmitted: (value) {
                performSearch();
              },
            ),
            const SizedBox(height: 20),
            if (searchQuery.isNotEmpty)
              Text(
                'Search Results for: $searchQuery',
                style: const TextStyle(color: Color(0xFF94FF4C), fontSize: 16),
              ),
            ...filteredShipments.map((shipment) => ShipmentCard(
                  iconColor: Color(int.parse(shipment['iconColor']!)),
                  productName: shipment['productName']!,
                  productId: shipment['productId']!,
                )),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Secound_background_color,
        selectedItemColor: green_color, // Color for the selected icon
        unselectedItemColor:
            const Color(0xFF31333D), // Color for the unselected icons
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '',
          ),
        ],
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DriverHomePage()),
            );
          } else if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const DriverHistoryOrders()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DriverSettingsScreen()),
            );
          }
        },
      ),
    );
  }
}
