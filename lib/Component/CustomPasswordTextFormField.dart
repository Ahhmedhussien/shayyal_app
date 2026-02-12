import 'package:flutter/material.dart';
import 'package:shyal/const.dart';

class CustomPasswordTextFormField extends StatefulWidget {
  final TextEditingController passwordController;

  const CustomPasswordTextFormField(
      {super.key, required this.passwordController});

  @override
  State<CustomPasswordTextFormField> createState() =>
      _CustomPasswordTextFormFieldState();
}

class _CustomPasswordTextFormFieldState
    extends State<CustomPasswordTextFormField> {
  late FocusNode _passwordFocusNode;
  Color _iconColor = Colors.grey;
  bool _passwordVisible = false;

  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
    _passwordVisible = false;

    _passwordFocusNode.addListener(() {
      if (_passwordFocusNode.hasFocus) {
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
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a password';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters long';
        }
        return null;
      },
      controller: widget.passwordController,
      obscureText: !_passwordVisible,
      keyboardType: TextInputType.visiblePassword,
      focusNode: _passwordFocusNode,
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
        prefixIcon: Icon(Icons.password_outlined, color: _iconColor),
        suffixIcon: IconButton(
          icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: _iconColor),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
        hintText: 'Eeter Your password',
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: Secound_background_color,
      ),
    );
  }
}
