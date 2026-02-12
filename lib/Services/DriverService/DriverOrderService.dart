import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shyal/Models/DriverModels/DriverOrders.dart';
import 'package:shyal/Services/Authentcation.dart';
import 'package:shyal/const.dart';

class DriverOrderService {
  Future<List<DriverOrder>> fetchDriverOrders() async {
    final authentcation = Authentcation();
    String? token = await authentcation.getToken();
    if (token == null)
      throw Exception('Authentication token is not available.');

    final response = await http.get(
      Uri.parse('$baseUrl/Driver/driver-orders'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<DriverOrder> orders =
          body.map((dynamic item) => DriverOrder.fromJson(item)).toList();
      return orders;
    } else {
      throw Exception('Failed to load driver orders');
    }
  }
}
