import 'package:flutter/material.dart';
import 'package:shyal/Component/CustomButton.dart';
import 'package:shyal/Component/CustomDropDownMenu.dart';
import 'package:shyal/Component/CustomTextFormField.dart';
import 'package:shyal/Models/Address.dart';
import 'package:shyal/Services/AddressService.dart';
import 'package:shyal/Widgets/PickMap.dart';
import 'package:shyal/const.dart';

class edit_address_screen extends StatefulWidget {
  final String id;
  final String name;
  final String phone;
  final String address;
  final int type;
  final String city;
  final String country;
  final double lat;
  final double long;

  const edit_address_screen(
      {super.key,
      required this.name,
      required this.phone,
      required this.address,
      required this.city,
      required this.country,
      required this.lat,
      required this.long,
      required this.type,
      required this.id});

  @override
  _edit_address_screenState createState() => _edit_address_screenState();
}

class _edit_address_screenState extends State<edit_address_screen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late String _selectedAddressType;
  late String _selectedCountry;
  late String _selectedCity;
  late double _latitude;
  late double _longitude;

  final List<String> _countries = ["Egypt"];
  final List<String> _cities = ["Asyut"];

  final AddressService _addressService = AddressService();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
    _addressController.text = widget.address;
    _phoneController.text = widget.phone;
    _selectedAddressType = widget.type == 1 ? 'Home' : 'Other';
    _selectedCountry = widget.country;
    _selectedCity = widget.city;
    _latitude = widget.lat;
    _longitude = widget.long;
  }

  void _saveAddress() async {
    if (_formKey.currentState!.validate()) {
      final addressRequest = AddressRequest(
        type: _selectedAddressType == 'Home' ? 1 : 2,
        name: _nameController.text,
        phone: _phoneController.text,
        city: _selectedCity,
        country: _selectedCountry,
        formattedAddress: _addressController.text,
        latitude: _latitude,
        longitude: _longitude,
      );

      try {
        final response =
            await _addressService.editAddress(widget.id, addressRequest);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message)),
        );
        if (response.flag) {
          Navigator.pushReplacementNamed(context, '/MyAddressScreen');
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      }
    }
  }

  Future<void> _selectAddress() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PickMap(
          padding: EdgeInsets.all(16),
        ),
      ),
    );

    if (result != null) {
      setState(() {
        _addressController.text = result['formattedAddress'];
        _latitude = result['latitude'];
        _longitude = result['longitude'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = screenWidth * 0.04;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: background_color,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Edit Address'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(padding),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextFormField(
                      hint: "Enter Name",
                      keyboardType: TextInputType.name,
                      controller: _nameController,
                      validator: notNull,
                    ),
                    SizedBox(height: padding),
                    CustomTextFormField(
                      hint: 'Enter Phone Number',
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
                      validator: validatePhone,
                    ),
                    SizedBox(height: padding),
                    CustomDropdownFormField(
                      hint: 'Enter Country',
                      items: _countries,
                      parentContext: context,
                      isAddress: false,
                      defultValue: _selectedCountry,
                      onSelected: (value) {
                        setState(() {
                          _selectedCountry = value;
                        });
                      },
                    ),
                    SizedBox(height: padding),
                    CustomDropdownFormField(
                      hint: 'Enter City',
                      items: _cities,
                      parentContext: context,
                      isAddress: false,
                      defultValue: _selectedCity,
                      onSelected: (value) {
                        setState(() {
                          _selectedCity = value;
                        });
                      },
                    ),
                    SizedBox(height: padding),
                    GestureDetector(
                      onTap: _selectAddress,
                      child: AbsorbPointer(
                        child: CustomTextFormField(
                          hint: 'Enter Address',
                          keyboardType: TextInputType.none,
                          controller: _addressController,
                          validator: notNull,
                        ),
                      ),
                    ),
                    SizedBox(height: padding * 1.5),
                    _buildAddressTypeButtons(),
                    SizedBox(height: padding * 1.5),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(padding),
            child: CustomButton(title: 'Save Address', onPressed: _saveAddress),
          )
        ],
      ),
    );
  }

  Widget _buildAddressTypeButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildChoiceChip('Home', _selectedAddressType == 'Home'),
        _buildChoiceChip('Other', _selectedAddressType == 'Other'),
      ],
    );
  }

  Widget _buildChoiceChip(String label, bool selected) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (value) {
        setState(() {
          _selectedAddressType = label;
        });
      },
      selectedColor: green_color,
      backgroundColor: Secound_background_color,
      labelStyle: const TextStyle(color: Colors.white),
    );
  }
}
