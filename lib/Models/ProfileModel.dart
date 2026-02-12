import 'dart:convert';

class ProfileModel {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final List<int>? profileImage;

  ProfileModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    this.profileImage,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      firstName: json['firstName'] ?? "",
      lastName: json['lastName'] ?? "",
      email: json['email'] ?? "",
      phone: json['phone'] ?? "",
      profileImage: json['profileImage'] != null
          ? base64Decode(json['profileImage'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'profileImage': profileImage != null ? base64Encode(profileImage!) : null,
    };
  }
}

class EditProfileModel {
  final String firstName;
  final String lastName;
  final String phone;

  EditProfileModel({
    required this.firstName,
    required this.lastName,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
    };
  }

  // Construct a Profile from a JSON map.
  factory EditProfileModel.fromJson(Map<String, dynamic> json) {
    return EditProfileModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      phone: json['phone'],
    );
  }
}
