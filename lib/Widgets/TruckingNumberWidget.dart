import 'package:flutter/material.dart';
import 'package:shyal/const.dart';

class TruckingNumberWidget extends StatelessWidget {
  const TruckingNumberWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Using MediaQuery to get screen width
    var screenWidth = MediaQuery.of(context).size.width;

    // Define padding dynamically based on screen size
    double containerPadding = screenWidth * 0.05; // 5% of the screen width
    double betweenElements = screenWidth * 0.02; // 2% of the screen width
    double buttonWidth = screenWidth * 0.15; // 15% of the screen width

    return Container(
      padding: EdgeInsets.all(containerPadding),
      decoration: BoxDecoration(
        color: const Color(0xff152721),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Track Your Package',
            style: TextStyle(
              fontSize:
                  screenWidth * 0.045, // 4.5% of the screen width for font size
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          SizedBox(height: betweenElements),
          Text(
            'Please enter your Tracking Number ',
            style: TextStyle(
              fontSize: screenWidth * 0.045, // Adjust font size accordingly
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
          SizedBox(height: betweenElements * 2),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 22, 31, 28),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Tracking Number',
                    hintStyle: TextStyle(
                        color: Colors.white, fontSize: screenWidth * 0.04),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: containerPadding,
                    ),
                  ),
                ),
              ),
              SizedBox(width: betweenElements),
              ElevatedButton(
                onPressed: () {
                  // Implement tracking logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Secound_green_color,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: buttonWidth / 4, // 25% of the button width
                    vertical: 15,
                  ),
                ),
                child: const Icon(Icons.arrow_forward),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
