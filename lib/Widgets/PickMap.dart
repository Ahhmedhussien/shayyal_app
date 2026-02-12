import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class PickMap extends StatefulWidget {
  const PickMap({
    super.key,
    required this.padding,
  });

  final EdgeInsets padding;

  @override
  State<PickMap> createState() => _PickMapState();
}

class _PickMapState extends State<PickMap> {
  late MapController _mapController;
  LatLng _selectedLocation =
      const LatLng(27.193108848510683, 31.182058597485483);
  String _formattedAddress = "Formatted Address Example";

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  void _onTap(LatLng location) async {
    setState(() {
      _selectedLocation = location;
    });
    String address = await _getAddressFromLatLng(location);
    setState(() {
      _formattedAddress = address;
    });
  }

  void _saveLocation() {
    Navigator.pop(context, {
      'formattedAddress': _formattedAddress,
      'latitude': _selectedLocation.latitude,
      'longitude': _selectedLocation.longitude,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveLocation,
          ),    
        ],
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
            onTap: (tapPosition, point) => _onTap(point),
            initialCenter: _selectedLocation,
            initialZoom: 17,
            interactionOptions: const InteractionOptions(
                flags: ~InteractiveFlag.doubleTapZoom)),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.test_map',
            subdomains: const ['a', 'b', 'c'],
          ),
          if (_selectedLocation != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: _selectedLocation!,
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 40.0,
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }

  Future<String> _getAddressFromLatLng(LatLng location) async {
    final url =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=${location.latitude}&lon=${location.longitude}';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['display_name'];
    } else {
      throw Exception('Failed to load address');
    }
  }
}
