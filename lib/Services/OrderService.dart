import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shyal/Models/InventoryPlaceOrder.dart';
import 'package:shyal/Models/OrderInventoryResponse.dart';
import 'package:shyal/Models/Orders.dart';
import 'package:shyal/Services/Authentcation.dart';
import 'package:shyal/const.dart';

class OrdersService {
  Future<List<Orders>> fetchPendingOrders() async {
    final auth = Authentcation();
    String? token = await auth.getToken();
    if (token == null) {
      throw Exception('UnAuthrized');
    }
    final response = await http.get(
      Uri.parse('$baseUrl/Customer/my-pending-orders'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Orders> orders =
          body.map((dynamic item) => Orders.fromJson(item)).toList();
      return orders;
    } else {
      throw Exception('Failed to load pending orders');
    }
  }

  Future<List<Orders>> fetchCompletedOrders() async {
    final auth = Authentcation();
    String? token = await auth.getToken();
    if (token == null) {
      throw Exception('UnAuthrized');
    }
    final response = await http.get(
      Uri.parse('$baseUrl/Customer/my-completed-orders'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Orders> orders =
          body.map((dynamic item) => Orders.fromJson(item)).toList();
      return orders;
    } else {
      throw Exception('Failed to load completed orders');
    }
  }

  Future<Orders> fetchLastOrder() async {
    final auth = Authentcation();
    String? token = await auth.getToken();
    if (token == null) {
      throw Exception('UnAuthrized');
    }
    final response = await http.get(
      Uri.parse('$baseUrl/Customer/last-order'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      Orders order = Orders.fromJson(body);
      return order;
    } else {
      throw Exception('Failed to load order');
    }
  }

  Future<OrderInventoryResponseModel> createOrder(
      OrderDetails orderRequest) async {
    final auth = Authentcation();
    String? token = await auth.getToken();
    if (token == null) {
      throw Exception('Unauthorized');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/your-endpoint'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: json.encode(orderRequest.toJson()),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return OrderInventoryResponseModel.fromJson(data);
    } else {
      throw Exception('Failed to create order: ${response.body}');
    }
  }
}
