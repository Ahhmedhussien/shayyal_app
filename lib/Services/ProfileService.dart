import 'dart:convert';
import 'dart:io';
import 'package:shyal/LogServes.dart';
import 'package:shyal/Models/ProfileModel.dart';
import 'package:http/http.dart' as http;
import 'package:shyal/Services/Authentcation.dart';
import 'package:shyal/const.dart';

class ProfileService {
  Future<ProfileModel> fetchProfile() async {
    final auth = Authentcation();
    String? token = await auth.getToken();
    if (token == null) {
      throw Exception('Unauthorized');
    }
    final response = await http.get(
      Uri.parse('$baseUrl/AdminHome/Profile'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body);

      return ProfileModel.fromJson(body[0]);
    } else {
      throw Exception('Failed to load profile: ${response.statusCode}');
    }
  }

  Future<bool> updateProfile(EditProfileModel profile) async {
    final auth = Authentcation();
    String? token = await auth.getToken();
    if (token == null) {
      throw Exception('Unauthorized: Token is null');
    }

    String url = '$baseUrl/AdminHome/UpdateAdminInfo';
    try {
      var response = await http.put(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
        body: json.encode(profile.toJson()),
      );

      if (response.statusCode == 200) {
        // Assuming the server sends back the updated profile
        EditProfileModel updatedProfile =
            EditProfileModel.fromJson(json.decode(response.body));
        return true; // Successful update
      } else {
        // Log error details for troubleshooting
        LogService.error('Failed to update profile: ${response.statusCode}');
        LogService.error('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Exception when calling API: $e');
      return false;
    }
  }

  Future<void> updateAdminProfile({
    File? profileImage,
  }) async {
    try {
      final auth = Authentcation();
      String? token = await auth.getToken();
      if (token == null) {
        throw Exception('UnAuthrized');
      }
      Uri uri =
          Uri.parse('$baseUrl/AdminHome/UpdateAdminInfo'); // Your API endpoint
      var request = http.MultipartRequest('PUT', uri)
        ..headers['Authorization'] = 'Bearer $token';

      if (profileImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'profileImage', profileImage.path));
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        LogService.info('Admin profile updated successfully');
      } else {
        LogService.error(
            'Failed to update admin profile: ${response.statusCode}');
      }
    } catch (e) {
      LogService.error('Error updating admin profile: $e');
    }
  }
}
