import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shyal/Component/CustomButton.dart';
import 'package:shyal/Services/Authentcation.dart';
import 'package:shyal/Widgets/OTP.dart';
import 'package:shyal/const.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  final String token;

  const OtpScreen({
    super.key,
    required this.email,
    required this.token,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;
  bool _isResending = false;
  String? _errorMessage;
  String? _resendMessage;
  int _timer = 30;
  Timer? _countdownTimer;
  final Authentcation _authService = Authentcation();
  String navigateTo = "";

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = 30;
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timer > 0) {
          _timer--;
        } else {
          _countdownTimer?.cancel();
        }
      });
    });
  }

  void verifyOtp(String otp) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    bool isVerified = await _authService.verifyOtp(int.parse(otp));

    setState(() {
      _isLoading = false;

      if (isVerified) {
        Navigator.pushReplacementNamed(context, '/LoginScreen');
      } else {
        _errorMessage = 'Invalid OTP. Please try again.';
      }
    });
  }

  Future<void> resendOtp() async {
    setState(() {
      _isResending = true;
      _resendMessage = null;
    });

    bool result = await _authService.sendOtp();

    setState(() {
      _isResending = false;
      _resendMessage =
          result ? 'OTP resent successfully!' : 'Failed to resend OTP.';
    });

    @override
    void dispose() {
      _countdownTimer?.cancel();
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Authentcation _authService = Authentcation();
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: background_color,
        title: const Text('Enter OTP'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(screenSize.width * 0.05),
          child: Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter OTP Code',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: screenSize.width * 0.08),
                    ),
                    SizedBox(height: screenSize.height * 0.02),
                    Text(
                      'OTP code has been sent to :${widget.email}',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: screenSize.width * 0.05),
                    ),
                    SizedBox(height: screenSize.height * 0.02),
                    OTP(otpController: _otpController, onCompleted: verifyOtp),
                    SizedBox(height: screenSize.height * 0.02),
                    if (_isLoading)
                      const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      )
                    else
                      CustomButton(
                          title: 'Validate OTP',
                          onPressed: () => verifyOtp(_otpController.text)),
                    SizedBox(height: screenSize.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_timer > 0)
                          Text(
                            'Resend OTP in $_timer seconds',
                            style: const TextStyle(color: Colors.grey),
                          )
                        else
                          TextButton(
                            onPressed: _isResending ? null : resendOtp,
                            child: _isResending
                                ? const CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        green_color),
                                  )
                                : const Text(
                                    'Resend OTP',
                                    style: TextStyle(color: green_color),
                                  ),
                          ),
                      ],
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
