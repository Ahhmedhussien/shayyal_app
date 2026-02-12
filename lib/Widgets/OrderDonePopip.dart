import 'package:flutter/material.dart';
import 'package:shyal/const.dart';

void showSusccessDialog(BuildContext context,
    {icon, title, subtitle, buttontitle}) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenWidth * 0.04),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Secound_background_color,
            borderRadius: BorderRadius.circular(screenWidth * 0.04),
          ),
          padding: EdgeInsets.all(screenWidth * 0.08),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: green_color,
                radius: screenWidth * 0.12,
                child: Icon(
                  icon,
                  size: screenWidth * 0.10,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: screenWidth * 0.04),
              Text(
                title,
                style: TextStyle(
                  fontSize: screenWidth * 0.05, // Adjust the size as needed
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Adjust the text color as needed
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: screenWidth * 0.04, // Adjust the size as needed
                  color: Colors.white70, // Adjust the text color as needed
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.03),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, '/TrackPackageScreen');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      green_color, // Replace with your desired button color
                  shape: const StadiumBorder(),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.08,
                    vertical: screenHeight * 0.015,
                  ),
                  child: Text(
                    buttontitle,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize:
                            screenWidth * 0.04), // Adjust the size as needed
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
