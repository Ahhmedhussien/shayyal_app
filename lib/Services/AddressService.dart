import 'dart:convert';

import 'package:shyal/Models/Address.dart';
import 'package:http/http.dart' as http;
import 'package:shyal/Services/Authentcation.dart';
import 'package:shyal/const.dart';

class AddressService {
  Future<List<Address>> fetchAddresses() async {
    try {
      final auth = Authentcation();
      String? token = await auth.getToken();

      if (token == null) {
        throw Exception('Authentication token is null');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/Customer/all-addresses'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<dynamic> data = jsonResponse['data'];

        return data.map((item) => Address.fromJson(item)).toList();
      } else {
        throw Exception(
            'Failed to load addresses: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (error) {
      throw Exception('Failed to load addresses: $error');
    }
  }

  Future<List<String>> fetchFormattedAddresses() async {
    try {
      final auth = Authentcation();
      String? token = await auth.getToken();

      if (token == null) {
        throw Exception('Authentication token is null');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/Customer/all-addresses'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<dynamic> data = jsonResponse['data'];

        // Extract only the formattedAddress from each Address
        List<String> formattedAddresses =
            data.map((item) => item['formattedAddress'].toString()).toList();
        return formattedAddresses;
      } else {
        throw Exception(
            'Failed to load addresses: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (error) {
      throw Exception('Failed to load addresses: $error');
    }
  }

  Future<Address> fetchAddressById(String id) async {
    final auth = Authentcation();
    String? token = await auth.getToken();

    if (token == null) {
      throw Exception('Authentication token is null');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/Customer/address?id=$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return Address.fromJson(jsonResponse);
    } else {
      throw Exception(
          'Failed to load address: ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<BaseResponse> addAddress(AddressRequest address) async {
    try {
      final auth = Authentcation();
      String? token = await auth.getToken();
      if (token == null) {
        return BaseResponse(
            flag: false, message: 'Authentication token is null');
      }

      final response = await http.post(
        Uri.parse('$baseUrl/Customer/add-address'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(address.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return BaseResponse(flag: true, message: 'Address Added Successfully');
      } else {
        return BaseResponse(
            flag: false,
            message:
                'Failed to add address: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (error) {
      return BaseResponse(
          flag: false, message: 'Failed to add address: $error');
    }
  }

  Future<BaseResponse> editAddress(String id, AddressRequest request) async {
    try {
      final auth = Authentcation();
      String? token = await auth.getToken();

      if (token == null) {
        return BaseResponse(
            flag: false, message: 'Authentication token is null');
      }

      final response = await http.put(
        Uri.parse('http://10.0.0.84:5104/api/Customer/edit-address?id=$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(request.toJson()),
      );

      if (response.statusCode == 200) {
        return BaseResponse(
            flag: true, message: 'Address Updated Successfully');
      } else {
        return BaseResponse(
            flag: false,
            message:
                'Failed to update address: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (error) {
      return BaseResponse(
          flag: false, message: 'Failed to update address: $error');
    }
  }

  Future<BaseResponse> deleteAddress(String id) async {
    try {
      final auth = Authentcation();
      String? token = await auth.getToken();

      if (token == null) {
        return BaseResponse(
            flag: false, message: 'Authentication token is null');
      }

      final response = await http.delete(
        Uri.parse('$baseUrl/Customer/delete-address?id=$id'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return BaseResponse(
            flag: true, message: 'Address Deleted Successfully');
      } else {
        return BaseResponse(
            flag: false,
            message:
                'Failed to delete address: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (error) {
      return BaseResponse(
          flag: false, message: 'Failed to delete address: $error');
    }
  }
//   Future<List<AddressDetail>> fetchAddressDetails() async {
//   try {
//     final auth = Authentcation();
//     String? token = await auth.getToken();

//     if (token == null) {
//       throw Exception('Authentication token is null');
//     }

//     final response = await http.get(
//       Uri.parse('$baseUrl/Customer/all-addresses'),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//     );

//     if (response.statusCode == 200) {
//       List<dynamic> jsonResponse = json.decode(response.body);
//       return jsonResponse.map((item) => AddressDetail.fromJson(item)).toList();
//     } else {
//       throw Exception('Failed to load addresses: ${response.statusCode} ${response.reasonPhrase}');
//     }
//   } catch (error) {
//     throw Exception('Failed to load addresses: $error');
//   }
// }
}
