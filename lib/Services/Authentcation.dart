import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shyal/LogServes.dart';
import 'package:shyal/Models/Address.dart';
import 'package:shyal/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentcation {
  Future<Map<String, dynamic>> registerUser(
      BuildContext context,
      String firstName,
      String lastName,
      String email,
      String password,
      String confirmPassword,
      String phoneNumber,
      int gender,
      String role) async {
    var url = Uri.parse('$baseUrl/UserAccount/register');

    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'FirstName': firstName,
        'LastName': lastName,
        'Email': email,
        'password': password,
        'confirmPassword': confirmPassword,
        'PhoneNumber': phoneNumber,
        'Gender': gender,
        'role': 2,
      }),
    );
    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      LogService.info('Registration successful: $data');
      Navigator.pushReplacementNamed(context, '/LoginScreen');
      return {
        'success': true,
        'data': responseBody,
      };
    } else {
      LogService.error('Failed to register. Status code: ${response.body}');
      return {
        'success': false,
        'data': responseBody,
      };
    }
  }

  // Future<Map<String, dynamic>> login(String email, String password) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('$baseUrl/UserAccount/login'),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({'email': email, 'password': password}),
  //     );

  //     final responseBody = jsonDecode(response.body);

  //     if (response.statusCode == 200) {
  //       SharedPreferences prefs = await SharedPreferences.getInstance();
  //       await prefs.setString('token', responseBody['token']);

  //       if (responseBody['flag'] == true) {

  //         if (responseBody['isEmailConfirmed'] == true) {
  //           return {'success': true, 'navigateTo': '/HomeScreen'};
  //         } else {
  //           return {
  //             'success': true,
  //             'navigateTo': '/OtpScreen',
  //             'token': responseBody['token'],
  //             'email': email
  //           };
  //         }
  //       } else {
  //         return {
  //           'success': false,
  //           'message': responseBody['message'] ?? 'Invalid Email or Password'
  //         };
  //       }
  //     } else {
  //       return {
  //         'success': false,
  //         'message':
  //             responseBody['message'] ?? 'Login failed due to server error'
  //       };
  //     }
  //   } catch (e) {
  //     LogService.error(e.toString());
  //     if (e is FormatException) {
  //       LogService.error('JSON Format Error: $e');
  //     }
  //     return {
  //       'success': false,
  //       'message': 'An error occurred. Please try again later.'
  //     };
  //   }
  // }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/UserAccount/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (responseBody['token'] != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', responseBody['token']);
        }

        if (responseBody['flag'] == true) {
          final userType = responseBody['userType'];
          final isEmailConfirmed = responseBody['isEmailConfirmed'];

          if (userType == 3) {
            if (isEmailConfirmed == true) {
              return {'success': true, 'navigateTo': '/DriverHomePage'};
            } else {
              return {
                'success': true,
                'navigateTo': '/OtpScreen',
                'token': responseBody['token'],
                'email': email
              };
            }
          } else {
            if (isEmailConfirmed == true) {
              return {'success': true, 'navigateTo': '/HomeScreen'};
            } else {
              return {
                'success': true,
                'navigateTo': '/OtpScreen',
                'userType': responseBody[userType],
                'token': responseBody['token'],
                'email': email
              };
            }
          }
        } else {
          return {
            'success': false,
            'message': responseBody['message'] ?? 'Invalid Email or Password'
          };
        }
      } else {
        return {
          'success': false,
          'message':
              responseBody['message'] ?? 'Login failed due to server error'
        };
      }
    } catch (e) {
      LogService.error(e.toString());
      if (e is FormatException) {
        LogService.error('JSON Format Error: $e');
      }
      return {
        'success': false,
        'message': 'An error occurred. Please try again later.'
      };
    }
  }

  Future<bool> sendOtp() async {
    String? token = await getToken();
    if (token == null) {
      print("No token available");
      return false;
    }
    final response = await http.post(
      Uri.parse('$baseUrl/UserAccount/send-otp'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      LogService.info('Send Otp  successful: ${response.statusCode}');
      return true;
    } else {
      LogService.error('${response.body}');
      return false;
    }
  }

  Future<Map<String, dynamic>> sendOtpWithEmail(String email) async {
    String? token = await getToken();
    if (token == null) {
      print("No token available");
      return {'success': false, 'message': 'Not Authoraized'};
    }

    if (email.isEmpty) {
      return {'success': false, 'message': 'Email cannot be empty'};
    } else if (!email.contains('@')) {
      return {'success': false, 'message': 'Invalid email address'};
    } else {
      final response = await http.post(
        Uri.parse('$baseUrl/UserAccount/send-otp'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        LogService.info('Send Otp  successful: ${response.statusCode}');
        return {'success': false, 'message': 'Otp Sended'};
      } else {
        LogService.error('${response.body}');
        return {
          'success': false,
          'message': 'There Are Error ${response.body}'
        };
      }
    }
  }

  Future<bool> verifyOtp(int otp) async {
    String? token = await getToken();
    if (token == null) {
      print("No token available");
      return false;
    }
    final response = await http.get(
      Uri.parse('$baseUrl/UserAccount/verify-otp?otp=$otp'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      LogService.info('Send Otp  successful: ${response.statusCode}');
      return true;
    } else {
      LogService.error('${response.headers}');
      return false;
    }
  }

  Future<bool> sendOtpForForgetPass(String email) async {
    String? token = await getToken();
    if (token == null) {
      print("No token available");
      return false;
    }
    final url = Uri.parse('$baseUrl/UserAccount/send-otp');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: json.encode({'email': email}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(
          'Failed to send OTP: ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<BaseResponse> forgetPassword(
      int otp, String newPassword, String email) async {
    final uri = Uri.parse(baseUrl).replace(
      path: 'api/Customer/Forget-password',
      queryParameters: {
        'otp': otp.toString(),
        'newPassword': newPassword,
        'email': email,
      },
    );

    final response = await http.put(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    LogService.info(
        'Response Status: ${response.statusCode}'); // Debugging: log the status code
    LogService.info(
        'Response Body: ${response.body}'); // Debugging: log the response body

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      return BaseResponse.fromJson(responseBody);
    } else {
      throw Exception(
          'Failed to reset password: ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  // Future<BaseResponse> resetPassword(
  //     String oldPassword, String newPassword) async {
  //   String? token = await getToken();
  //   if (token == null) {
  //     throw Exception('UnAuthrized');
  //   }
  //   final url = Uri.parse('$baseUrl/UserAccount/reset-password');

  //   final response = await http.put(
  //     url,
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token'
  //     },
  //     body: json.encode({
  //       'oldPassword': oldPassword,
  //       'newPassword': newPassword,
  //     }),
  //   );

  //   LogService.info('Response Status: ${response.statusCode}');
  //   LogService.info('Response Body: ${response.body}');

  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> responseBody = json.decode(response.body);
  //     LogService.info('Decoded Response: $responseBody');
  //     return BaseResponse.fromJson(responseBody);
  //   } else {
  //     throw Exception(
  //         'Failed to reset password: ${response.statusCode} ${response.reasonPhrase}');
  //   }
  // }

  Future<BaseResponse> resetPassword(
      String oldPassword, String newPassword) async {
    String? token = await getToken();
    if (token == null) {
      throw Exception('UnAuthrized');
    }
    // final url = Uri.parse('$baseUrl/UserAccount/reset-password');
    final url = Uri.parse(baseUrl).replace(
      path: 'api/UserAccount/reset-password',
      queryParameters: {
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      },
    );

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      print(
          'Decoded Response: $responseBody'); // Debugging: log the decoded response
      return BaseResponse.fromJson(responseBody);
    } else {
      throw Exception(
          'Failed to reset password: ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
