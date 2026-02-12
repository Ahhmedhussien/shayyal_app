import 'package:flutter/material.dart';
import 'package:shyal/Models/Address.dart';
import 'package:shyal/Screens/LoginScreen.dart';
import 'package:shyal/Services/Authentcation.dart';
import 'package:shyal/Widgets/OTP.dart';
import 'package:shyal/const.dart';
import 'package:shyal/Component/CustomButton.dart';
import 'package:shyal/Component/CustomTextFormField.dart';

class OtpPasswordScreen extends StatefulWidget {
  final String email;

  const OtpPasswordScreen({super.key, required this.email});

  @override
  State<OtpPasswordScreen> createState() => _OtpPasswordScreenState();
}

class _OtpPasswordScreenState extends State<OtpPasswordScreen> {
  final _otpController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _authService = Authentcation();
  bool _isLoading = false;
  String? _errorMessage;

  void _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _errorMessage = null;
      });
      try {
        final otp = int.parse(_otpController.text);
        final newPassword = _newPasswordController.text;
        final email = widget.email;

        BaseResponse response =
            await _authService.forgetPassword(otp, newPassword, email);

        if (response.flag) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        } else {
          _errorMessage = response.message;
        }
      } catch (error) {
        setState(() {
          _errorMessage = error.toString();
        });
      }
    }
  }

  @override
  void dispose() {
    _otpController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: background_color,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(screenSize.width * 0.05),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/img/logo1.png',
                          width: screenSize.width * 0.3,
                        ),
                        SizedBox(height: screenSize.height * 0.01),
                        Text(
                          "Reset Password",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenSize.width * 0.08,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.02),
                        Text(
                          "Enter the OTP sent to your email, and set your new password.",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: screenSize.width * 0.04,
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.02),
                        OTP(
                          otpController: _otpController,
                          onCompleted: (value) {
                            print("OTP Entered: $value");
                          },
                        ),
                        SizedBox(height: screenSize.height * 0.02),
                        CustomTextFormField(
                            validator: validatePassword,
                            controller: _newPasswordController,
                            hint: 'Enter New Password',
                            leftIcon: Icons.lock_outlined,
                            passwordVisible: Icons.visibility_outlined,
                            passwordVisibleOff: Icons.visibility_off_outlined,
                            keyboardType: TextInputType.visiblePassword),
                        SizedBox(height: screenSize.height * 0.02),
                        CustomTextFormField(
                            validator: validatePassword,
                            controller: _confirmPasswordController,
                            hint: 'Confirm New Password',
                            leftIcon: Icons.lock_outlined,
                            passwordVisible: Icons.visibility_outlined,
                            passwordVisibleOff: Icons.visibility_off_outlined,
                            keyboardType: TextInputType.visiblePassword),
                        SizedBox(height: screenSize.height * 0.02),
                        if (_errorMessage != null)
                          Padding(
                            padding: EdgeInsets.only(
                                top: screenSize.height * 0.002,
                                bottom: screenSize.height * 0.02),
                            child: Text(
                              _errorMessage!,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        _isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(green_color),
                              ))
                            : CustomButton(
                                title: 'Reset Password',
                                onPressed: _resetPassword,
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
