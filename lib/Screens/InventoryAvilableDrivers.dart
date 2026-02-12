import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shyal/Component/CustomButton.dart';
import 'package:shyal/LogServes.dart';
import 'package:shyal/Models/AvailableDriversDTO.dart';
import 'package:shyal/Screens/InventoryReceiverDetails.dart';
import 'package:shyal/Screens/ReceiverDetailsScreen.dart';
import 'package:shyal/Services/DriversService.dart';
import 'package:shyal/const.dart';


class InventoryAvailableDriversScreen extends StatefulWidget {
  final String Sendername;
  final String SenderphoneNumber;
  final String Senderaddress;
  final DateTime Senddate;
  final int packageWeight;
  final String description;
  const InventoryAvailableDriversScreen(
      {super.key,
      required this.Sendername,
      required this.SenderphoneNumber,
      required this.Senderaddress,
      required this.Senddate,
      required this.packageWeight,
      required this.description});

  @override
  State<InventoryAvailableDriversScreen> createState() =>
      _InventoryAvailableDriversScreenState();
}

class _InventoryAvailableDriversScreenState
    extends State<InventoryAvailableDriversScreen> {
  DriversService driversService = DriversService();
  List<AvailableDriversDTO> drivers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadDrivers();
  }

  void loadDrivers() async {
    try {
      List<AvailableDriversDTO> loadedDrivers =
          await driversService.fetchAvailableDrivers(widget.packageWeight);
      setState(() {
        drivers = loadedDrivers;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      LogService.error('Failed to load drivers: $e');
    }
  }

  AvailableDriversDTO? selectedDriver;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background_color,
        title: const Text('Available Drivers'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/SendPackageScreen');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : drivers.isEmpty
                      ? const Center(
                          child: Text(
                              "No available drivers at the moment Try again later.",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)))
                      : ListView.builder(
                          itemCount: drivers.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedDriver = drivers[index];
                                  });
                                },
                                child: DriverCard(
                                  driver: drivers[index],
                                  isSelected: selectedDriver == drivers[index],
                                ));
                          },
                        ),
            ),
            const SizedBox(height: 16.0),
            CustomButton(
                title: "Next",
                onPressed: () {
                  if (selectedDriver != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InventoryReceiverDetails(
                                senderName: widget.Sendername,
                                senderPhoneNumber: widget.SenderphoneNumber,
                                senderAddress: widget.Senderaddress,
                                date: widget.Senddate,
                                packageWeight: widget.packageWeight,
                                driverid: selectedDriver!.driverId,
                                description: widget.description,
                              )),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Please select a driver first!')));
                  }
                })
          ],
        ),
      ),
    );
  }
}

class DriverCard extends StatelessWidget {
  final AvailableDriversDTO driver;
  final bool isSelected;

  const DriverCard({super.key, required this.driver, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: background_color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: isSelected ? green_color : Colors.transparent,
          width: 2.0,
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: driver.vehicleImage != null
                      ? MemoryImage(driver.vehicleImage!)
                      : const AssetImage('assets/img/vic.png')
                          as ImageProvider, // Handle null vehicle image                  fit: BoxFit.cover,
                ),
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${driver.firstName}  ${driver.lastName}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  const Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 16.0),
                      SizedBox(width: 4.0),
                      Text(
                        "4.5 (100 reviews)",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                ],
              ),
            ),
            Container(
              width: 80.0,
              height: 70.0,
              decoration: BoxDecoration(
                // shape: BoxShape.circle,
                borderRadius: BorderRadius.circular(24),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: driver.vehicleImage != null
                      ? MemoryImage(driver.vehicleImage!)
                      : const AssetImage('assets/img/AlanWalker.jpg')
                          as ImageProvider,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
