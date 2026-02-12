import 'package:flutter/material.dart';
import 'package:shyal/Component/CustomButton.dart';
import 'package:shyal/Component/CustomTextFormField.dart';
import 'package:shyal/Screens/ForgetPassswordOTP.dart';
import 'package:shyal/Services/Authentcation.dart';
import 'package:shyal/const.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _authService = Authentcation();
  bool _isLoading = false;
  String? _errorMessage;

  void _sendOtp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _errorMessage = null;
        _isLoading = true;
      });
      try {
        bool success =
            await _authService.sendOtpForForgetPass(_emailController.text);
        if (success) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OtpPasswordScreen(
                      email: _emailController.text,
                    )),
          );
        }
      } catch (error) {
        setState(() {
          _errorMessage = error.toString();
          _isLoading = false;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $error')));
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
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
                          "Forgot Password",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenSize.width * 0.08,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.02),
                        Text(
                          "Enter your email to receive an OTP",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: screenSize.width * 0.04,
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.02),
                        CustomTextFormField(
                            validator: validateEmail,
                            controller: _emailController,
                            hint: 'Enter Your Email',
                            leftIcon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress),
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
                                title: 'Send OTP',
                                onPressed: _sendOtp,
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
