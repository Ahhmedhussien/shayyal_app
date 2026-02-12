import 'package:flutter/material.dart';
import 'package:shyal/Component/CustomButton.dart';
import 'package:shyal/Component/CustomDatePickerFormField.dart';
import 'package:shyal/Component/CustomDropDownMenu.dart';
import 'package:shyal/Component/CustomTextFormField.dart';
import 'package:shyal/Component/CustomTimePickerFormField.dart';
import 'package:shyal/LogServes.dart';
import 'package:shyal/Models/Address.dart';
import 'package:shyal/Models/InventoryPlaceOrder.dart';
import 'package:shyal/Models/OrderInventoryResponse.dart';
import 'package:shyal/Models/OrderResponse.dart';
import 'package:shyal/Models/PlaceOrder.dart';
import 'package:shyal/Screens/CheckoutScreen.dart';
import 'package:shyal/Screens/InventoryCheckout.dart';
import 'package:shyal/Screens/InventoryOrder.dart';
import 'package:shyal/Services/AddressService.dart';
import 'package:shyal/Services/DriversService.dart';
import 'package:shyal/Services/OrderService.dart';
import 'package:shyal/Widgets/OrderDonePopip.dart';

import 'package:shyal/const.dart';

class InventoryReceiverDetails extends StatefulWidget {
  final String senderName;
  final String senderPhoneNumber;
  final String senderAddress;
  final DateTime date;
  final int packageWeight;
  final String driverid;
  final String description;

  const InventoryReceiverDetails(
      {super.key,
      required this.senderName,
      required this.senderPhoneNumber,
      required this.senderAddress,
      required this.date,
      required this.packageWeight,
      required this.driverid,
      required this.description});

  @override
  State<InventoryReceiverDetails> createState() =>
      _InventoryReceiverDetailsState();
}

class _InventoryReceiverDetailsState extends State<InventoryReceiverDetails> {
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _messageController = TextEditingController();
  final _addressController = TextEditingController();
  final _timeController = TextEditingController();
  final _dateController = TextEditingController();

  DriversService driversService = DriversService();
  // String? _addressController;
  bool _isLoading = false;
  String? _orderResponseDetails;
  late Future<List<Address>> formattedAddresses;
  late Future<Address> futureSenderAddress;
  late Future<Address> futureReceverAddress;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String? _selectedAddressId;
  final ordersService = OrdersService();

  @override
  void initState() {
    super.initState();
    formattedAddresses = AddressService().fetchAddresses();
    futureSenderAddress =
        AddressService().fetchAddressById(widget.senderAddress);
    futureSenderAddress =
        AddressService().fetchAddressById(_selectedAddressId!);
  }

  DateTime _combineDateAndTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  Future<OrderInventoryResponseModel> _handlePlaceOrder() async {
    setState(() {
      _isLoading = true;
    });

    try {
      DateTime combinedDateTime =
          _combineDateAndTime(_selectedDate, _selectedTime);
      final senderAddress =
          await AddressService().fetchAddressById(widget.senderAddress);
      final receiverAddress =
          await AddressService().fetchAddressById(_selectedAddressId!);

      InventorySenderDetails senderDetails = InventorySenderDetails(
        name: widget.senderName,
        mobileNumber: widget.senderPhoneNumber,
        addressID: widget.senderAddress,
        latitude: senderAddress.latitude,
        longitude: senderAddress.longitude,
      );

      InventoruyReceiverDetails receiverDetails = InventoruyReceiverDetails(
        name: _nameController.text,
        mobileNumber: _phoneNumberController.text,
        addressID: _addressController
            .text, // Make sure this is properly set as the selected address ID
        latitude: receiverAddress.latitude,
        longitude: receiverAddress.longitude,
        message: _messageController.text,
      );

      OrderDetails orderDetails = OrderDetails(
        senderDetails: senderDetails,
        receiverDetails: receiverDetails,
        orderSize: widget.packageWeight,
        description: widget.description,
        receivingDateTime: widget.date,
        leavingDateTime: combinedDateTime,
        inventoryFee: 0,
      );

      OrderInventoryResponseModel response =
          await OrdersService().createOrder(orderDetails);

      setState(() {
        _isLoading = false;
      });

      return response;
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      print('Failed to place order: $e');
      throw Exception('Failed to place order: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Responsive padding
    final EdgeInsetsGeometry padding =
        EdgeInsets.all(MediaQuery.of(context).size.width * 0.04);
    // Responsive spacing
    final double space = MediaQuery.of(context).size.height * 0.02;

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
              Navigator.pop(context);
            },
          ),
        ),
        body: SafeArea(
          child: Center(
            child: _isLoading
                ? const CircularProgressIndicator()
                : Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          padding: padding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                'Receiver Details',
                                style: TextStyle(
                                  fontSize: titlefontsize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: space),
                              CustomTextFormField(
                                controller: _nameController,
                                validator: notNull,
                                keyboardType: TextInputType.text,
                                hint: 'Enter Name',
                              ),
                              SizedBox(height: space),
                              CustomTextFormField(
                                controller: _phoneNumberController,
                                validator: notNull,
                                keyboardType: TextInputType.phone,
                                hint: 'Enter Mobile Number',
                              ),
                              SizedBox(height: space),
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
                                                element.formattedAddress ==
                                                value);
                                        _selectedAddressId = selectedAddress
                                            .id; // Capture the selected address ID
                                      },
                                    );
                                  } else {
                                    return Text('No addresses found');
                                  }
                                },
                              ),
                              SizedBox(height: space),
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
                              SizedBox(height: space),
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
                              SizedBox(height: space),
                              MessageTextform(
                                hint: 'Enter Message',
                                textAreaHeight:
                                    MediaQuery.of(context).size.height * 0.2,
                                controller: _messageController,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: padding,
                        child: CustomButton(
                          title: 'Book Now',
                          onPressed: () async {
                            try {
                              OrderInventoryResponseModel response =
                                  await _handlePlaceOrder();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => InventoryCheckoutScreen(
                                    orderResponse: response,
                                  ),
                                ),
                              );
                            } catch (e) {
                              LogService.error("Error placing the order: $e");
                            }
                          },
                          // onPressed: () => showSusccessDialog(
                          //   context,
                          //   icon: Icons.check,
                          //   title: 'Your Shipment has been booked Successfully',
                          //   subtitle:
                          //       'you can track your shipment with tracking id: #20287352341',
                          //   buttontitle: 'Track Shipment',
                          // ),
                        ),
                      )
                    ],
                  ),
          ),
        ));
  }
}

class MessageTextform extends StatelessWidget {
  const MessageTextform(
      {super.key,
      required this.hint,
      required this.textAreaHeight,
      required this.controller});
  final String hint;
  final double textAreaHeight;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: textAreaHeight,
      child: TextFormField(
        controller: controller,
        style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.width * 0.04),
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Color(0xff007C4F),
            ),
          ),

          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white54),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: MediaQuery.of(context).size.height * 0.05,
          ), // Padding inside the text field
          filled: true,
          fillColor: const Color(0xff2F3B37),
        ),
      ),
    );
  }
}
