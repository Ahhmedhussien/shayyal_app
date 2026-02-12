import 'package:flutter/material.dart';
import 'package:shyal/Component/CustomButton.dart';
import 'package:shyal/Component/CustomDropDownMenu.dart';
import 'package:shyal/Component/CustomTextFormField.dart';
import 'package:shyal/Models/Address.dart';
import 'package:shyal/Services/AddressService.dart';
import 'package:shyal/Widgets/PickMap.dart';
import 'package:shyal/const.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String _selectedAddressType = 'Home';

  final List<String> _countries = ["Egypt"];
  final List<String> _cities = ["Asyut"];

  String _selectedCountry = "Egypt";
  String _selectedCity = "Asyut";

  double? _latitude;
  double? _longitude;

  final AddressService _addressService = AddressService();

  void _saveAddress() async {
    if (_formKey.currentState!.validate()) {
      final addressRequest = AddressRequest(
        type: _selectedAddressType == 'Home' ? 1 : 2,
        name: _nameController.text,
        phone: _phoneController.text,
        city: _selectedCity,
        country: _selectedCountry,
        formattedAddress: _addressController.text,
        latitude: _latitude ?? 0.0,
        longitude: _longitude ?? 0.0,
      );

      try {
        final response = await _addressService.addAddress(addressRequest);
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
            }),
        title: const Text('Add Address'),
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
                        validator: notNull),
                    SizedBox(height: padding),
                    CustomTextFormField(
                        hint: 'Enter Phone Number',
                        keyboardType: TextInputType.phone,
                        controller: _phoneController,
                        validator: validatePhone),
                    SizedBox(height: padding),
                    CustomDropdownFormField(
                      hint: 'Enter Country',
                      items: _countries,
                      parentContext: context,
                      isAddress: false,
                      defultValue: _selectedCountry,
                      onSelected: (value) {
                        _selectedCountry = value;
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
                        _selectedCity = value;
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
                            validator: notNull),
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
