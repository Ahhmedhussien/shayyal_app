import 'package:flutter/material.dart';
import 'package:shyal/const.dart';

class CustomTextFormField extends StatefulWidget {
  final String hint;
  final keyboardType;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final IconData? passwordVisible;
  final IconData? passwordVisibleOff;
  final String? initialValue; // Optional parameter for default value

  final VoidCallback? onRightIconPressed;

  const CustomTextFormField({
    super.key,
    required this.hint,
    required this.keyboardType,
    required this.controller,
    required this.validator,
    this.leftIcon,
    this.rightIcon,
    this.onRightIconPressed,
    this.passwordVisible,
    this.passwordVisibleOff,
    this.initialValue,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late FocusNode _passwordFocusNode;
  Color _iconColor = Colors.grey;
  bool _passwordVisible = false;
  bool _isValid = true;

  @override
  void didUpdateWidget(covariant CustomTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      widget.controller.text = widget.initialValue ?? "";
    }
  }

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
    _passwordVisible = false;
    widget.controller.text = widget.initialValue ?? "";

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
      focusNode: _passwordFocusNode,
      controller: widget.controller,
      validator: (value) {
        final validationMessage = widget.validator(value);
        setState(() {
          _isValid = validationMessage == null;
          _iconColor = _isValid ? green_color : Color(0xffB5918F);
        });
        return validationMessage;
      },
      obscureText: widget.passwordVisible != null ? !_passwordVisible : false,
      keyboardType: widget.keyboardType,
      style: TextStyle(
          color: Colors.white,
          fontSize: MediaQuery.of(context).size.width * 0.04),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: green_color,
          ),
        ),
        hintText: widget.hint,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: Secound_background_color,
        prefixIcon: widget.leftIcon != null
            ? Icon(widget.leftIcon, color: _iconColor)
            : null,
        suffixIcon: widget.passwordVisible != null
            ? IconButton(
                icon: Icon(
                    _passwordVisible
                        ? widget.passwordVisible
                        : widget.passwordVisibleOff,
                    color: _iconColor),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              )
            : null,
      ),
    );
  }
}
