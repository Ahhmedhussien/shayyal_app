// import 'package:flutter/material.dart';
// import 'package:shyal/Component/CustomButton.dart';
// import 'package:shyal/Component/CustomDatePickerFormField.dart';
// import 'package:shyal/Component/CustomDropDownMenu.dart';
// import 'package:shyal/Component/CustomTextFormField.dart';
// import 'package:shyal/Component/CustomTimePickerFormField.dart';
// import 'package:shyal/Models/Address.dart';
// import 'package:shyal/Screens/AvailableDriversScreen.dart';
// import 'package:shyal/Services/AddressService.dart';
// import 'package:shyal/Widgets/PackageSizeSelector.dart';
// import 'package:shyal/const.dart';

// class SendPackageScreen extends StatefulWidget {
//   const SendPackageScreen({super.key});

//   @override
//   State<SendPackageScreen> createState() => _SendPackageScreenState();
// }

// class _SendPackageScreenState extends State<SendPackageScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _phoneNumberController = TextEditingController();
//   final _timeController = TextEditingController();
//   final _dateController = TextEditingController();
//   final _addressController = TextEditingController();

//   DateTime _selectedDate = DateTime.now();
//   TimeOfDay _selectedTime = TimeOfDay.now();
//   int _selectedPackageIndex = 0;
//   int packageWeight = 0;

//   final _addressService = AddressService();
//   late Future<List<FormatedAddress>> futureAddresses;
//   late Future<List<String>> formattedAddresses;

//   @override
//   void initState() {
//     super.initState();
//     formattedAddresses = AddressService().fetchFormattedAddresses();
//     }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _phoneNumberController.dispose();
//     _dateController.dispose();
//     _timeController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // MediaQueryData can be used to get the size and orientation of the screen
//     final mediaQueryData = MediaQuery.of(context);
//     final EdgeInsetsGeometry padding =
//         EdgeInsets.all(MediaQuery.of(context).size.width * 0.04);

//     final double screenHeight = mediaQueryData.size.height;

//     final double responsiveFontSize = MediaQuery.of(context).size.width * 0.05;

//     final double standardSpacing = screenHeight * 0.02;

//     final double titlefontsize = MediaQuery.of(context).size.width * 0.07;

//     return Scaffold(
//       backgroundColor: background_color,
//       appBar: AppBar(
//         backgroundColor: background_color,
//         title: const Text('Send Package'),
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pushReplacementNamed(context, '/HomeScreen');
//           },
//         ),
//       ),
//       body: SafeArea(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               Expanded(
//                 child: SingleChildScrollView(
//                   padding: padding,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Sender Details',
//                         style: TextStyle(
//                           fontSize: titlefontsize,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: standardSpacing),
//                       CustomTextFormField(
//                           controller: _nameController,
//                           validator: notNull,
//                           keyboardType: TextInputType.text,
//                           hint: 'Enter Name'),
//                       SizedBox(height: standardSpacing),
//                       CustomTextFormField(
//                         controller: _phoneNumberController,
//                         validator: notNull,
//                         hint: 'Enter Mobile Number',
//                         keyboardType: TextInputType.phone,
//                       ),
//                       SizedBox(height: standardSpacing),
//                       CustomDropdownFormField(
//                         items: addressList,
//                         hint: 'Enter Address',
//                         parentContext: context,
//                         isAddress: true,
//                         defultValue: 'Select Address',
//                         onSelected: (value) {
//                           _addressController.text = value;
//                         },
//                       ),
//                       SizedBox(height: standardSpacing),
//                       CustomDatePickerFormField(
//                         hint: 'Pickup Date',
//                         onDateSelected: (DateTime date) {
//                           setState(() {
//                             _selectedDate = date;
//                           });
//                         },
//                         controller: _dateController,
//                         defaultDate: DateTime.now(),
//                       ),
//                       SizedBox(height: standardSpacing),
//                       CustomTimePickerFormField(
//                         hint: 'Pickup Time',
//                         onTimeSelected: (TimeOfDay time) {
//                           setState(() {
//                             _selectedTime = time;
//                           });
//                         },
//                         controller: _timeController,
//                         defaultTime: TimeOfDay.now(),
//                       ),
//                       SizedBox(height: standardSpacing),
//                       Text(
//                         'Package Weight',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: responsiveFontSize,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: standardSpacing),
//                       PackageSizeSelector(
//                         onSelectionChanged: (index) {
//                           setState(() {
//                             _selectedPackageIndex = index;
//                             packageWeight =
//                                 index == 0 ? 749 : (index == 1 ? 1999 : 2001);
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: padding,
//                 child: CustomButton(
//                   title: 'Next',
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => AvailableDriversScreen(
//                                   name: _nameController.text,
//                                   phoneNumber: _phoneNumberController.text,
//                                   address: _addressController.text,
//                                   date: _selectedDate,
//                                   time: _selectedTime,
//                                   packageWeight: packageWeight,
//                                 )),
//                       );
//                     } else {
//                       // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                       //     content: Text('Please enter all required data')));
//                     }
//                   },
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:shyal/Component/CustomButton.dart';
import 'package:shyal/Component/CustomDatePickerFormField.dart';
import 'package:shyal/Component/CustomDropDownMenu.dart';
import 'package:shyal/Component/CustomTextFormField.dart';
import 'package:shyal/Component/CustomTimePickerFormField.dart';
import 'package:shyal/Models/Address.dart';
import 'package:shyal/Screens/AvailableDriversScreen.dart';
import 'package:shyal/Services/AddressService.dart';
import 'package:shyal/Widgets/PackageSizeSelector.dart';
import 'package:shyal/const.dart';

class SendPackageScreen extends StatefulWidget {
  const SendPackageScreen({super.key});

  @override
  State<SendPackageScreen> createState() => _SendPackageScreenState();
}

class _SendPackageScreenState extends State<SendPackageScreen> {
    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController();
    final _phoneNumberController = TextEditingController();
    final _timeController = TextEditingController();
    final _dateController = TextEditingController();
    final _addressController = TextEditingController();
    final _descriptionController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  int _selectedPackageIndex = 0;
  int packageWeight = 0;

  late Future<List<Address>> formattedAddresses;

  @override
  void initState() {
    super.initState();
    formattedAddresses = AddressService().fetchAddresses();
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
        title: const Text('Send Package'),
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
                                // Now you have the selected address with lat and long
                                // You can pass `selectedAddress` to the next screen
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
                      Text(
                        'Package Weight',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: responsiveFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: standardSpacing),
                      PackageSizeSelector(
                        onSelectionChanged: (index) {
                          setState(() {
                            _selectedPackageIndex = index;
                            packageWeight =
                                index == 0 ? 749 : (index == 1 ? 1999 : 2001);
                          });
                        },
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AvailableDriversScreen(
                                  name: _nameController.text,
                                  phoneNumber: _phoneNumberController.text,
                                  address: _addressController.text,
                                  date: _selectedDate,
                                  time: _selectedTime,
                                  packageWeight: packageWeight,
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
