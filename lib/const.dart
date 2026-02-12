import 'package:flutter/material.dart';
import 'dart:math';

const Color green_color = Color(0xff007C4F);
const Color Secound_green_color = Color(0xff004F32);
const Color background_color = Color(0xff1D2623);
const Color Secound_background_color = Color(0xff2F3B37);

const Color green = Color(0xff00C27C);
const String baseUrl = 'http://192.168.76.106:5104/api';

enum Gender { male, female }

String? validatePhone(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter $value';
  } else if (!RegExp(r'^01[0-9]{9}$').hasMatch(value)) {
    return 'Please enter a valid phone number starting with 01 and containing 11 digits';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }
  if (value.length <= 8) {
    return 'Password must be more than 8 characters';
  }
  final passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
  if (!passwordRegex.hasMatch(value)) {
    return 'Password must contain at least:\n- One uppercase letter\n- One lowercase letter\n- One number\n- One special character';
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please Enter Your Email';
  } else {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\\.,;:\s@\"]+\.)+[^<>()[\]\\.,;:\s@\"]{2,})$';
    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
  }
  return null;
}

String? notNull(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please Enter This Field';
  }
  return null;
}

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  var radiusOfEarth = 6371;
  return radiusOfEarth * 2 * asin(sqrt(a));
}
