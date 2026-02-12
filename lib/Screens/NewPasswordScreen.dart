import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shyal/Component/CustomButton.dart';
import 'package:shyal/Component/CustomTextFormField.dart';
import 'package:shyal/Models/Address.dart';
import 'package:shyal/Screens/LoginScreen.dart';
import 'package:shyal/Services/Authentcation.dart';
import 'package:shyal/const.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _oldpasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _authService = Authentcation();

  String? _errorMessage;
  void _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _errorMessage = null;
      });
      try {
        final oldPassword = _oldpasswordController.text;
        final newPassword = _passwordController.text;

        BaseResponse response =
            await _authService.resetPassword(oldPassword, newPassword);

        if (response.flag) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        } else {
          setState(() {
            _errorMessage = response.message;
          });
        }
      } catch (error) {
        setState(() {
          _errorMessage = error.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background_color,
        title: const Text('Reset Password'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/LoginScreen');
          },
        ),
      ),
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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Enter New Password ',
                          style: TextStyle(
                            fontSize: screenSize.width * 0.08,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.05),
                        CustomTextFormField(
                            validator: notNull,
                            controller: _oldpasswordController,
                            hint: 'Enter Old Password',
                            leftIcon: Icons.password_outlined,
                            passwordVisible: Icons.visibility_outlined,
                            passwordVisibleOff: Icons.visibility_off_outlined,
                            keyboardType: TextInputType.visiblePassword),
                        SizedBox(height: screenSize.height * 0.02),
                        CustomTextFormField(
                            validator: validatePassword,
                            controller: _passwordController,
                            hint: 'Enter New Password',
                            leftIcon: Icons.password_outlined,
                            passwordVisible: Icons.visibility_outlined,
                            passwordVisibleOff: Icons.visibility_off_outlined,
                            keyboardType: TextInputType.visiblePassword),
                        SizedBox(height: screenSize.height * 0.02),
                        CustomTextFormField(
                            validator: validatePassword,
                            controller: _confirmPasswordController,
                            hint: 'Re-Enter Password',
                            leftIcon: Icons.password_outlined,
                            passwordVisible: Icons.visibility_outlined,
                            passwordVisibleOff: Icons.visibility_off_outlined,
                            keyboardType: TextInputType.visiblePassword),
                        if (_errorMessage != null) ...[
                          const SizedBox(height: 16.0),
                          Text(
                            _errorMessage!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenSize.height * 0.02),
                CustomButton(title: 'Next', onPressed: _resetPassword)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
