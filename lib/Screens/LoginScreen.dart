import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shyal/Component/CustomButton.dart';

import 'package:shyal/Component/CustomTextFormField.dart';
import 'package:shyal/Component/LoginWith.dart';
import 'package:shyal/Screens/ForgetpasswordScreen.dart';
import 'package:shyal/Screens/OtpScreen.dart';
import 'package:shyal/Services/Authentcation.dart';
import 'package:shyal/const.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final Authentcation _authService = Authentcation();
  bool _isLoading = false;
  String? _errorMessage;

  void _SendOtp() async {
    await _authService.sendOtp();
  }

  // void _login() async {
  //   if (_formKey.currentState!.validate()) {
  //     setState(() {
  //       _isLoading = true;
  //       _errorMessage = null;
  //     });

  //     final response = await _authService.login(
  //       _emailController.text,
  //       _passwordController.text,
  //     );

  //     setState(() {
  //       _isLoading = false;
  //       if (response['success']) {
  //         if (response['navigateTo'] == '/HomeScreen') {
  //           Navigator.pushReplacementNamed(context, '/HomeScreen');
  //         } else if (response['navigateTo'] == '/OtpScreen') {
  //           _SendOtp();

  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => OtpScreen(
  //                       email: response['email'],
  //                       token: response['token'],
  //                     )),
  //           );
  //         }
  //       } else {
  //         _errorMessage = response['message'];
  //       }
  //     });
  //   }
  // }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final response = await _authService.login(
        _emailController.text,
        _passwordController.text,
      );

      setState(() {
        _isLoading = false;
        if (response['success']) {
          if (response['navigateTo'] == '/HomeScreen') {
            Navigator.pushReplacementNamed(context, '/HomeScreen');
          } else if (response['navigateTo'] == '/DriverHomePage') {
            Navigator.pushReplacementNamed(context, '/DriverHomePage');
          } else if (response['navigateTo'] == '/OtpScreen') {
            _SendOtp();

            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OtpScreen(
                        email: response['email'],
                        token: response['token'],
                      )),
            );
          }
        } else {
          _errorMessage = response['message'];
        }
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double imageSize = screenSize.width * 0.3;

    return Scaffold(
      backgroundColor: background_color,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(screenSize.width * 0.05),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/img/logo1.png',
                          width: imageSize,
                        ),
                        SizedBox(height: screenSize.height * 0.01),
                        Text(
                          "Shayal",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenSize.width * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.03),
                        Text(
                          "Let's get you Login ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenSize.width * 0.08,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.02),
                        Text(
                          "Enter your information below",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: screenSize.width * 0.04,
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.02),
                        CustomTextFormField(
                            validator: notNull,
                            controller: _emailController,
                            hint: 'Enter Your Email',
                            leftIcon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress),
                        SizedBox(height: screenSize.height * 0.02),
                        CustomTextFormField(
                            validator: notNull,
                            controller: _passwordController,
                            hint: 'Enter Your Password',
                            leftIcon: Icons.password_outlined,
                            passwordVisible: Icons.visibility_outlined,
                            passwordVisibleOff: Icons.visibility_off_outlined,
                            keyboardType: TextInputType.visiblePassword),
                        SizedBox(height: screenSize.height * 0.005),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/ForgotPasswordScreen');
                              },
                              child: const Text(
                                'Forget Password?',
                                style: TextStyle(color: green_color),
                              )),
                        ),
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
                                title: 'Login',
                                onPressed: () {
                                  _login();
                                },
                              ),
                        SizedBox(height: screenSize.height * 0.02),
                        SizedBox(height: screenSize.height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(
                                    right: screenSize.width * 0.03),
                                child: Divider(
                                  color: Colors.grey,
                                  height: screenSize.height * 0.05,
                                ),
                              ),
                            ),
                            const Text("Or login with"),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: screenSize.width * 0.03),
                                child: Divider(
                                  color: Colors.grey,
                                  height: screenSize.height * 0.05,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            LoginWith(
                              icon: SvgPicture.asset(
                                  'assets/icons/google_icon.svg',
                                  width: screenSize.width * 0.07),
                              lable: 'Google',
                              onPressed: () {},
                            ),
                            LoginWith(
                              icon: SvgPicture.asset(
                                  'assets/icons/facebook_icon.svg',
                                  width: screenSize.width * 0.07),
                              lable: 'Facebook',
                              onPressed: () {},
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not our member yet?',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: screenSize.width * 0.04)),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, '/RegistrationScreen');
                      },
                      child: Text('Register Now',
                          style: TextStyle(
                              color: green_color,
                              fontSize: screenSize.width * 0.04)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
