import 'package:shyal/const.dart';

class CustomerDTO {
  final String firstname;
  final String lastname;
  final String email;
  final String password;
  final String confirmPassword;
  final Gender gender;
  final String phoneNumber;
  final String role;

  CustomerDTO({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.gender,
    required this.phoneNumber,
    required this.role,
  });

  factory CustomerDTO.fromJson(Map<String, dynamic> json) {
    return CustomerDTO(
        firstname: json["FirstName"],
        lastname: json["LastName"],
        email: json["Email"],
        password: json["password"],
        confirmPassword: json["confirmPassword"],
        gender: json["Gender"],
        phoneNumber: json["PhoneNumber"],
        role: json["role"]);
  }
}
