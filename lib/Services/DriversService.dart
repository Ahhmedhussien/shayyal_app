import 'dart:convert';

import 'package:shyal/LogServes.dart';
import 'package:shyal/Models/AvailableDriversDTO.dart';
import 'package:shyal/Models/OrderResponse.dart';
import 'package:shyal/Models/PlaceOrder.dart';
import 'package:shyal/Services/Authentcation.dart';
import 'package:shyal/const.dart';
import 'package:http/http.dart' as http;

class DriversService {
  Future<List<AvailableDriversDTO>> fetchAvailableDrivers(
      int packageWeight) async {
    try {
      final authentcation = Authentcation();
      String? token = await authentcation.getToken();

      if (token == null)
        throw Exception('Authentication token is not available.');
      var response = await http.get(
        Uri.parse(baseUrl +
            '/Customer/available-drivers?packageWeight=$packageWeight'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return parseDrivers(response.body);
      } else {
        throw Exception(
            'Failed to load drivers: HTTP status ${response.statusCode}');
      }
    } catch (e) {
      // Log the error or handle it appropriately
      throw Exception('Failed to connect to the API: $e');
    }
  }

  List<AvailableDriversDTO> parseDrivers(String responseBody) {
    final List<dynamic> parsed = json.decode(responseBody);
    return parsed
        .map<AvailableDriversDTO>((json) =>
            AvailableDriversDTO.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<OrderResponse> postOrder(PlaceOrder order, String driverid) async {
    final authentcation = Authentcation();
    String? token = await authentcation.getToken();

    if (token == null)
      throw Exception('Authentication token is not available.');

    var url = Uri.parse(baseUrl + '/Customer/place-order?driverId=$driverid');
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(order.toJson()),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      LogService.info('Secussesfully ordered');

      return OrderResponse.fromJson(responseBody);
    } else {
      throw Exception('Failed to submit order: ${response.body}');
    }
  }
}
