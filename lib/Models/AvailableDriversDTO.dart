import 'dart:convert';

import 'dart:typed_data';

class AvailableDriversDTO {
  final String driverId;
  final String firstName;
  final String lastName;
  final int type;
  final Uint8List? vehicleImage;
  final Uint8List? driverImage;

  AvailableDriversDTO(
      {required this.driverId,
      required this.firstName,
      required this.lastName,
      required this.type,
      this.vehicleImage,
      this.driverImage});

  factory AvailableDriversDTO.fromJson(Map<String, dynamic> json) {
    Uint8List? decodeImage(String? base64String) {
      if (base64String != null && base64String.isNotEmpty) {
        return base64Decode(base64String);
      }
      return null;
    }

    return AvailableDriversDTO(
      driverId: json['driverId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      type: json['type'],
      driverImage: decodeImage(json['driverImage']),
      vehicleImage: decodeImage(json['vehicleImage']),
    );
  }
}
