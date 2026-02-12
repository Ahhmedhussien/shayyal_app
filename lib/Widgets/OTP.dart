import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shyal/const.dart';

class OTP extends StatelessWidget {
  final TextEditingController otpController;
  final void Function(String)? onCompleted;
  const OTP(
      {super.key, required this.otpController, required this.onCompleted});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return PinCodeTextField(
      appContext: context,
      keyboardType: TextInputType.number,
      length: 4,
      obscureText: false,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(12),
        fieldHeight: screenSize.height * 0.07,
        fieldWidth: screenSize.width * 0.12,
        selectedColor: green_color,
        activeFillColor: background_color,
        activeColor: green_color,
        inactiveColor: Colors.grey,
        inactiveFillColor: Secound_background_color,
        selectedFillColor: Secound_background_color,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: background_color,
      enableActiveFill: true,
      controller: otpController,
      onCompleted: onCompleted,
      onChanged: (value) {
        print(value);
      },
      beforeTextPaste: (text) {
        print("Allowing to paste $text");
        return true;
      },
    );
  }
}
