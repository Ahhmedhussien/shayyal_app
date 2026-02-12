import 'package:flutter/material.dart';
import 'package:shyal/const.dart';

class CustomEmailTextFormField extends StatefulWidget {
  final TextEditingController emailController;

  const CustomEmailTextFormField({
    super.key,
    required this.emailController,
  });

  @override
  State<CustomEmailTextFormField> createState() =>
      _CustomEmailTextFormFieldState();
}

class _CustomEmailTextFormFieldState extends State<CustomEmailTextFormField> {
  late FocusNode _emailFocusNode;
  Color _iconColor = Colors.grey;

  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();

    _emailFocusNode.addListener(() {
      if (_emailFocusNode.hasFocus) {
        setState(() {
          _iconColor = green_color;
        });
      } else {
        setState(() {
          _iconColor = Colors.grey;
        });
      }
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.emailController,
      keyboardType: TextInputType.emailAddress,
      focusNode: _emailFocusNode,
      validator: (value) {
        return validateEmail(value);
      },
      style: TextStyle(
          color: Colors.grey,
          fontSize: MediaQuery.of(context).size.width * 0.04),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: green_color,
          ),
        ),
        prefixIcon: Icon(Icons.email_outlined, color: _iconColor),
        hintText: 'Enter Your Email',
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: Secound_background_color,
      ),
    );
  }
}
