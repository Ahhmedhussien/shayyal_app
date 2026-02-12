import 'package:flutter/material.dart';
import 'package:shyal/Models/DriverModels/DriverOrders.dart';
import 'package:shyal/Screens/DriverScreens/DriverHistoryOrders.dart';
import 'package:shyal/Screens/DriverScreens/DriverSettingsScreen.dart';
import 'package:shyal/Screens/DriverScreens/DriverTruckOrder.dart';
import 'package:shyal/Screens/DriverScreens/OrderCard.dart';
import 'package:shyal/Services/DriverService/DriverOrderService.dart';
import 'package:shyal/Services/DriversService.dart';
import 'package:shyal/Services/LocationService.dart';
import 'package:shyal/const.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({super.key});

  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  late Future<List<DriverOrder>> futureOrders;
  // final LocationService _locationService = LocationService();

  final DriverOrderService _orderService = DriverOrderService();

  void fetchOrders() {
    setState(() {
      futureOrders = _orderService.fetchDriverOrders();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_color,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Hello, Ahmed',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/img/AlanWalker.jpg',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(
                color: Colors.grey,
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'available orders',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: FutureBuilder<List<DriverOrder>>(
                  future: futureOrders,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No orders found'));
                    } else {
                      List<DriverOrder> orders = snapshot.data!;
                      return ListView.builder(
                          itemCount: orders.length,
                          itemBuilder: (context, index) {
                            DriverOrder order = orders[index];
                            return OrderCard(
                              order: order,
                              onPressedApprove: () {
                                // _locationService
                                //     .requestPermissionAndStartTracking(
                                //         order.driverId);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DriverTruckOrder(
                                      order: order,
                                      driverId: order
                                          .driverId, // Assuming you have driverId in your order model
                                    ),
                                  ),
                                );
                              },
                              onPressedDecline: () {},
                            );
                          });
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: green_color,
        selectedItemColor: green_color,
        unselectedItemColor: Secound_background_color,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping),
            label: '',
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
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
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
