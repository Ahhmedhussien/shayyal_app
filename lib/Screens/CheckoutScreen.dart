import 'package:flutter/material.dart';
import 'package:shyal/Component/CustomButton.dart';
import 'package:shyal/Component/HorizontalTimelineThreeTitle.dart';
import 'package:shyal/Models/OrderResponse.dart';
import 'package:shyal/Screens/HomeScreen.dart';
import 'package:shyal/Widgets/OrderDonePopip.dart';
import 'package:shyal/const.dart';

class CheckoutScreen extends StatelessWidget {
  final OrderResponse orderResponse;
  const CheckoutScreen({super.key, required this.orderResponse});

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
        centerTitle: true,
        title: const Text('Checkout'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/ReceiverDetailsScreen');
          },
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Your Order',
                    style: TextStyle(
                      fontSize: titlefontsize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: space),
                  Card(
                    color: Secound_background_color,
                    child: Column(
                      children: [
                        HorizontalTimelineThreeTitle(
                          title: orderResponse.senderName,
                          subtitle: orderResponse.senderAddress,
                          phonenumber: orderResponse.senderPhone,
                          isfirst: true,
                          islast: false,
                        ),
                        HorizontalTimelineThreeTitle(
                          title: orderResponse.receiverName,
                          subtitle: orderResponse.receiverAddress,
                          phonenumber: orderResponse.receiverPhone,
                          isfirst: false,
                          islast: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: space),
                  const Divider(
                    color: Colors.grey,
                    height: 40,
                  ),
                  SizedBox(height: space),
                  _buildPriceItem(
                      context, 'Shipping Fee', '${orderResponse.orderCost}'),
                  SizedBox(height: space),
                  _buildPriceItem(
                      context, 'app Fee', '${orderResponse.appFee}'),
                  // SizedBox(height: space),
                  // _buildPriceItem(context, 'Package Fee', '2\$'),
                  const Divider(
                    color: Colors.grey,
                    height: 40,
                  ),
                  _buildTotal(
                      context, 'Total Cost', '${orderResponse.totalCost}'),
                ],
              ),
            ),
          ),
          Padding(
            padding: padding,
            child: CustomButton(
                title: 'OK',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                }),
          )
        ],
      )),
    );
  }

  Widget _buildPriceItem(BuildContext context, String label, String cost) {
    final double fontSize =
        MediaQuery.of(context).size.width * 0.05; // Responsive font size

    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: fontSize),
          ),
          Text(
            cost,
            style: TextStyle(color: Colors.white, fontSize: fontSize),
          ),
        ],
      ),
    );
  }

  Widget _buildTotal(BuildContext context, String label, String totalCost) {
    final double fontSize =
        MediaQuery.of(context).size.width * 0.06; // Responsive font size
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
                color: Colors.white,
                fontSize: fontSize,
                fontWeight: FontWeight.bold),
          ),
          Text(
            totalCost,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
