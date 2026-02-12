import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shyal/Component/CustomButton.dart';
import 'package:shyal/Component/CustomGenderPicker.dart';
import 'package:shyal/Component/CustomTextFormField.dart';
import 'package:shyal/Component/LoginWith.dart';
import 'package:shyal/Services/Authentcation.dart';
import 'package:shyal/const.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final Authentcation _authService = Authentcation();
  final _phoneNumberController = TextEditingController();
  Gender? selectedGender = Gender.male;
  int _selectedGender = 1;
  bool _isLoading = false;
  String? _errorMessage;

  void _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final response = await _authService.registerUser(
          context,
          _firstNameController.text,
          _lastNameController.text,
          _emailController.text,
          _passwordController.text,
          _confirmPasswordController.text,
          _phoneNumberController.text,
          _selectedGender,
          "1");

      setState(() {
        _isLoading = false;
        if (!response['success']) {
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

  void _handleGenderChanged(int gender) {
    setState(() {
      _selectedGender = gender;
    });
    print('Selected gender: $gender'); // You can handle the gender change here
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double imageSize = screenSize.width * 0.3;

    return Scaffold(
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
                        "Register your new account!",
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
                        controller: _firstNameController,
                        hint: 'Enter First Name',
                        keyboardType: TextInputType.name,
                        validator: notNull,
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                      CustomTextFormField(
                          controller: _lastNameController,
                          validator: notNull,
                          hint: 'Enter Last Name',
                          keyboardType: TextInputType.name),
                      SizedBox(height: screenSize.height * 0.02),
                      CustomTextFormField(
                          validator: (value) {
                            return validateEmail(value);
                          },
                          controller: _emailController,
                          hint: 'Enter Email',
                          keyboardType: TextInputType.emailAddress),
                      SizedBox(height: screenSize.height * 0.02),
                      CustomTextFormField(
                          validator: validatePassword,
                          controller: _passwordController,
                          hint: 'Enter Password',
                          passwordVisible: Icons.visibility,
                          passwordVisibleOff: Icons.visibility_off,
                          keyboardType: TextInputType.visiblePassword),
                      SizedBox(height: screenSize.height * 0.02),
                      CustomTextFormField(
                          validator: validatePassword,
                          controller: _confirmPasswordController,
                          hint: 'Enter Confirm Password',
                          passwordVisible: Icons.visibility_outlined,
                          passwordVisibleOff: Icons.visibility_off_outlined,
                          keyboardType: TextInputType.visiblePassword),
                      SizedBox(height: screenSize.height * 0.02),
                      CustomTextFormField(
                          validator: notNull,
                          controller: _phoneNumberController,
                          hint: 'Enter Phone Number',
                          keyboardType: TextInputType.phone),
                      SizedBox(height: screenSize.height * 0.02),
                      GenderSelector(
                          initialGender: Gender.male,
                          onGenderChanged: _handleGenderChanged),
                    ],
                  ),
                ),
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
                      valueColor: AlwaysStoppedAnimation<Color>(green_color),
                    ))
                  : Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: CustomButton(
                        title: 'Register',
                        onPressed: () async {
                          _register();
                        },
                      ),
                    ),
              SizedBox(height: screenSize.height * 0.005),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: screenSize.width * 0.03),
                      child: Divider(
                        color: Colors.grey,
                        height: screenSize.height * 0.05,
                      ),
                    ),
                  ),
                  const Text("Or Register with"),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: screenSize.width * 0.03),
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
                    icon: SvgPicture.asset('assets/icons/google_icon.svg',
                        width: screenSize.width * 0.07),
                    lable: 'Google',
                    onPressed: () {},
                  ),
                  LoginWith(
                    icon: SvgPicture.asset('assets/icons/facebook_icon.svg',
                        width: screenSize.width * 0.07),
                    lable: 'Facebook',
                    onPressed: () {},
                  )
                ],
              ),
              SizedBox(height: screenSize.height * 0.005),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already a mamber?',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: screenSize.width * 0.04)),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/LoginScreen');
                    },
                    child: Text('Login Now',
                        style: TextStyle(
                            color: green_color,
                            fontSize: screenSize.width * 0.04)),
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
