import 'package:flutter/material.dart';
import 'package:shyal/Component/CustomButton.dart';
import 'package:shyal/Component/CustomDropDownMenu.dart';
import 'package:shyal/Component/CustomTextFormField.dart';
import 'package:shyal/LogServes.dart';
import 'package:shyal/Models/Address.dart';
import 'package:shyal/Models/OrderResponse.dart';
import 'package:shyal/Models/PlaceOrder.dart';
import 'package:shyal/Screens/CheckoutScreen.dart';
import 'package:shyal/Services/AddressService.dart';
import 'package:shyal/Services/DriversService.dart';
import 'package:shyal/Widgets/OrderDonePopip.dart';

import 'package:shyal/const.dart';

class ReceiverDetailsScreen extends StatefulWidget {
  final String senderName;
  final String senderPhoneNumber;
  final String senderAddress;
  final DateTime date;
  final TimeOfDay time;
  final int packageWeight;
  final String driverid;
  final int vehicleType;
  final String description;

  const ReceiverDetailsScreen(
      {super.key,
      required this.senderName,
      required this.senderPhoneNumber,
      required this.senderAddress,
      required this.date,
      required this.time,
      required this.packageWeight,
      required this.driverid,
      required this.vehicleType,
      required this.description});

  @override
  State<ReceiverDetailsScreen> createState() => _ReceiverDetailsScreenState();
}

class _ReceiverDetailsScreenState extends State<ReceiverDetailsScreen> {
  final _nameController = TextEditingController();
  final _PhoneNumberController = TextEditingController();
  final _MessageController = TextEditingController();

  DriversService driversService = DriversService();
  String? _addressController;
  bool _isLoading = false;
  String? _orderResponseDetails;
  late Future<List<Address>> formattedAddresses;

  @override
  void initState() {
    super.initState();
    formattedAddresses = AddressService().fetchAddresses();
  }

  Future<OrderResponse> _handlePlaceOrder() async {
    setState(() {
      _isLoading = true;
    });

    try {
      String formatTimeOfDay(TimeOfDay time) {
        final hour = time.hour.toString().padLeft(2, '0');
        final minute = time.minute.toString().padLeft(2, '0');
        return '$hour:$minute';
      }

      SenderDetails senderDetails = SenderDetails(
          name: widget.senderName,
          mobileNumber: widget.senderPhoneNumber,
          address: widget.senderAddress,
          date: widget.date,
          time: widget.time, // Convert TimeOfDay to String
          packageWeight: widget.packageWeight);

      ReceiverDetails receiverDetails = ReceiverDetails(
          name: _nameController.text,
          mobileNumber: _PhoneNumberController.text,
          address: _addressController!,
          message: _MessageController.text);

      PlaceOrder orderDetails = PlaceOrder(
        senderDetails: senderDetails,
        receiverDetails: receiverDetails,
        vehicleType: widget.vehicleType,
        totalDestination: 150.0,
        description: widget.description,
      );
      String driverId =
          widget.driverid; // You should fetch or define the driver ID as needed

      // Call the postOrder service
      OrderResponse response =
          await driversService.postOrder(orderDetails, driverId);

      // Update the state based on the response
      setState(() {
        _orderResponseDetails =
            "Order ID: ${response.orderId} - Total Cost: ${response.totalCost}";
        _isLoading = false; // Stop showing the loading indicator
      });
      return response;
    } catch (e) {
      setState(() {
        _orderResponseDetails = "Failed to place order: $e";
        _isLoading = false; // Stop showing the loading indicator
      });
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
                                controller: _PhoneNumberController,
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
                                        _addressController = value;
                                        Address selectedAddress = snapshot.data!
                                            .firstWhere((element) =>
                                                element.formattedAddress ==
                                                value);
                                        // Now you have the selected address with lat and long
                                        // You can pass `selectedAddress` to the next screen
                                      },
                                    );
                                  } else {
                                    return Text('No addresses found');
                                  }
                                },
                              ),
                              SizedBox(height: space),
                              MessageTextform(
                                hint: 'Enter Message',
                                textAreaHeight:
                                    MediaQuery.of(context).size.height * 0.2,
                                controller: _MessageController,
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
                              OrderResponse response =
                                  await _handlePlaceOrder();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CheckoutScreen(
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
