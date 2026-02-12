import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:shyal/Component/CustomButton.dart';
import 'package:shyal/Models/DriverModels/DriverOrders.dart';
import 'package:shyal/Services/LocationService.dart';
import 'package:shyal/const.dart';

class DriverTruckOrder extends StatefulWidget {
  const DriverTruckOrder(
      {super.key, required this.order, required this.driverId});
  final String driverId;
  final DriverOrder order;

  @override
  State<DriverTruckOrder> createState() => _DriverTruckOrderState();
}

class _DriverTruckOrderState extends State<DriverTruckOrder> {
  // final LocationService _locationService = LocationService();
  MapController mapController = MapController();
  List<Marker> _markers = [];

  

  // void _trackDriver() {
  //   _locationService
  //       .getDriverLocationStream(widget.driverId)
  //       .listen((position) {
  //     setState(() {
  //       _markers = [
  //         Marker(
  //           point: LatLng(position.latitude, position.longitude),
  //           child: const Icon(
  //             Icons.location_on,
  //             color: Colors.red,
  //             size: 40.0,
  //           ),
  //         )
  //       ];
  //     });
  //     mapController.move(LatLng(position.latitude, position.longitude), 15.0);
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _trackDriver();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_color,
      appBar: AppBar(
        backgroundColor: background_color,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Current Shipment', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              // decoration: BoxDecoration(
              //   color: const Color(0xFF31333D), // Placeholder for map
              //   borderRadius: BorderRadius.circular(12),
              //   image: const DecorationImage(
              //     image: AssetImage('assets/img/R.png'),
              //     fit: BoxFit.cover,
              //   ),
              // ),
              child: FlutterMap(
                mapController: mapController,
                options: const MapOptions(
                  initialCenter: LatLng(0, 0), // Initial position
                  initialZoom: 10.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    // userAgentPackageName: 'com.example.test_map',
                    subdomains: const ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                    markers: _markers,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/img/AlanWalker.jpg'), // Replace with your image URL
                  radius: 30,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ahmed Hussien',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Current Shipment',
              style: TextStyle(color: green_color, fontSize: 16),
            ),
            const Text(
              'ID: 13831445450',
              style: TextStyle(color: Color(0xFFD9D9D9), fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Text(
              'iPhone 14 pro max 356 G',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Text(
              'From: 2A EL-Khalifa EL-Maamoun St., 5th Floor\n(01124787479)',
              style: TextStyle(color: Color(0xFFD9D9D9), fontSize: 14),
            ),
            IconButton(
              icon: const Icon(Icons.call, color: green_color),
              onPressed: () {
                // Placeholder for call action
              },
            ),
            const Text(
              'To: 2 Sabri Abu Alam St., 2nd Floor\n(01000505035)',
              style: TextStyle(color: Color(0xFFD9D9D9), fontSize: 14),
            ),
            IconButton(
              icon: const Icon(Icons.call, color: green_color),
              onPressed: () {
                // Placeholder for call action
              },
            ),
            const SizedBox(height: 100),
            CustomButton(
              title: 'Go to Checkout',
              onPressed: () {
                Navigator.pushNamed(context, '/checkout');
              },
            ),
          ],
        ),
      ),
    );
  }
}
