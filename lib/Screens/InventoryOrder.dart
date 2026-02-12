import 'package:flutter/material.dart';
import 'package:shyal/Component/CustomButton.dart';
import 'package:shyal/Component/CustomDatePickerFormField.dart';
import 'package:shyal/Component/CustomDropDownMenu.dart';
import 'package:shyal/Component/CustomTextFormField.dart';
import 'package:shyal/Component/CustomTimePickerFormField.dart';
import 'package:shyal/Models/Address.dart';
import 'package:shyal/Screens/AvailableDriversScreen.dart';
import 'package:shyal/Screens/InventoryAvilableDrivers.dart';
import 'package:shyal/Services/AddressService.dart';
import 'package:shyal/const.dart';

class SenderInventoryOrder extends StatefulWidget {
  const SenderInventoryOrder({super.key});

  @override
  State<SenderInventoryOrder> createState() => _SenderInventoryOrderState();
}

class _SenderInventoryOrderState extends State<SenderInventoryOrder> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _timeController = TextEditingController();
  final _dateController = TextEditingController();
  final _addressController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _sizeController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  int _selectedPackageIndex = 0;
  int packageWeight = 0;
  String? _selectedAddressId; // Store the selected address ID

  late Future<List<Address>> formattedAddresses;

  @override
  void initState() {
    super.initState();
    formattedAddresses = AddressService().fetchAddresses();
  }

  DateTime _combineDateAndTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final EdgeInsetsGeometry padding =
        EdgeInsets.all(MediaQuery.of(context).size.width * 0.04);
    final double screenHeight = mediaQueryData.size.height;
    final double responsiveFontSize = MediaQuery.of(context).size.width * 0.05;
    final double standardSpacing = screenHeight * 0.02;
    final double titlefontsize = MediaQuery.of(context).size.width * 0.07;
    return Scaffold(
      backgroundColor: background_color,
      appBar: AppBar(
        backgroundColor: background_color,
        title: const Text('Send Package Inventory'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/HomeScreen');
          },
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: padding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sender Details',
                        style: TextStyle(
                          fontSize: titlefontsize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: standardSpacing),
                      CustomTextFormField(
                        controller: _nameController,
                        validator: notNull,
                        keyboardType: TextInputType.text,
                        hint: 'Enter Name',
                      ),
                      SizedBox(height: standardSpacing),
                      CustomTextFormField(
                        controller: _phoneNumberController,
                        validator: notNull,
                        hint: 'Enter Mobile Number',
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: standardSpacing),
                      CustomTextFormField(
                        controller: _descriptionController,
                        validator: notNull,
                        hint: 'Enter Description',
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: standardSpacing),
                      FutureBuilder<List<Address>>(
                        future: formattedAddresses,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData &&
                              snapshot.data!.isNotEmpty) {
                            return CustomDropdownFormField(
                              items: snapshot.data!
                                  .map((e) => e.formattedAddress)
                                  .toList(),
                              hint: 'Select Address',
                              parentContext: context,
                              isAddress: true,
                              defultValue:
                                  snapshot.data!.first.formattedAddress,
                              onSelected: (value) {
                                _addressController.text = value;

                                Address selectedAddress = snapshot.data!
                                    .firstWhere((element) =>
                                        element.formattedAddress == value);
                                _selectedAddressId = selectedAddress
                                    .id; // Capture the selected address ID
                              },
                            );
                          } else {
                            return Text('No addresses found');
                          }
                        },
                      ),
                      SizedBox(height: standardSpacing),
                      CustomDatePickerFormField(
                        hint: 'Pickup Date',
                        onDateSelected: (DateTime date) {
                          setState(() {
                            _selectedDate = date;
                          });
                        },
                        controller: _dateController,
                        defaultDate: DateTime.now(),
                      ),
                      SizedBox(height: standardSpacing),
                      CustomTimePickerFormField(
                        hint: 'Pickup Time',
                        onTimeSelected: (TimeOfDay time) {
                          setState(() {
                            _selectedTime = time;
                          });
                        },
                        controller: _timeController,
                        defaultTime: TimeOfDay.now(),
                      ),
                      SizedBox(height: standardSpacing),
                      CustomTextFormField(
                        controller: _sizeController,
                        validator: notNull,
                        hint: 'Enter Size Of Package',
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: padding,
                child: CustomButton(
                  title: 'Next',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      DateTime combinedDateTime =
                          _combineDateAndTime(_selectedDate, _selectedTime);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                InventoryAvailableDriversScreen(
                                  Sendername: _nameController.text,
                                  SenderphoneNumber:
                                      _phoneNumberController.text,
                                  Senderaddress: _selectedAddressId!,
                                  Senddate: combinedDateTime,
                                  packageWeight:
                                      int.parse(_sizeController.text),
                                  description: _descriptionController.text,
                                )),
                      );
                    } else {
                      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      //     content: Text('Please enter all required data')));
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
