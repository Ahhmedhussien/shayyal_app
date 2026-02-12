import 'package:flutter/material.dart';
import 'package:shyal/Component/AddressCard.dart';
import 'package:shyal/Component/CustomButton.dart';
import 'package:shyal/Models/Address.dart';
import 'package:shyal/Screens/EditAddressScreen.dart';
import 'package:shyal/Services/AddressService.dart';

import 'package:shyal/const.dart';

class MyAddressScreen extends StatefulWidget {
  const MyAddressScreen({super.key});

  @override
  State<MyAddressScreen> createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  late Future<List<Address>> _futureAddresses;
  final AddressService _addressService = AddressService();

  void _fetchAddresses() {
    _futureAddresses = _addressService.fetchAddresses();
  }

  void _deleteAddress(String id) async {
    try {
      await _addressService.deleteAddress(id).then((_) => _fetchAddresses());

    } catch (error) {
      _showSnackBar('Error: $error');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchAddresses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: background_color,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, '/ProfileScreen'),
        ),
        title: const Text('My Address'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: _futureAddresses,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No addresses found'));
                  } else {
                    List<Address> addresses = snapshot.data!;
                    return ListView.builder(
                      itemCount: addresses.length,
                      itemBuilder: (context, index) {
                        Address address = addresses[index];
                        return AddressCard(
                          type: address.type == 1 ? "Home" : "Other",
                          name: address.name,
                          phone: address.phone,
                          address: address.formattedAddress,
                          onEdit: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => edit_address_screen(
                                  id: address.id!,
                                  type: address.type!,
                                  address: address.formattedAddress,
                                  name: address.name,
                                  phone: address.phone,
                                  city: address.city,
                                  country: address.country,
                                  lat: address.latitude,
                                  long: address.longitude,
                                ),
                              ),
                            ).then((_) => _fetchAddresses());
                          },
                          onDelete: () async {
                            _deleteAddress(address.id!);
                          },
                        );
                      },
                    );
                  }
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
                title: 'Add New Address',
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/AddAddressScreen')
                      .then((_) => _fetchAddresses());
                }),
          ),
        ],
      ),
    );
  }
}
