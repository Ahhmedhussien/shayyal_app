class Address {
  final String? id;
  final int? type;
  final String name;
  final String phone;
  final String city;
  final String country;
  final String formattedAddress;
  final double latitude;
  final double longitude;

  Address({
    this.id,
    this.type,
    required this.name,
    required this.phone,
    required this.city,
    required this.country,
    required this.formattedAddress,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'phone': phone,
      'city': city,
      'country': country,
      'formattedAddress': formattedAddress,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      phone: json['phone'],
      city: json['city'],
      country: json['country'],
      formattedAddress: json['formattedAddress'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

class AddressRequest {
  final int type;
  final String name;
  final String phone;
  final String city;
  final String country;
  final String formattedAddress;
  final double latitude;
  final double longitude;

  AddressRequest({
    required this.type,
    required this.name,
    required this.phone,
    required this.city,
    required this.country,
    required this.formattedAddress,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'name': name,
      'phone': phone,
      'city': city,
      'country': country,
      'formattedAddress': formattedAddress,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class BaseResponse {
  final bool flag;
  final String message;

  BaseResponse({required this.flag, required this.message});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      flag: json['flag'] ?? false, // Default to false if null
      message: json['message'] ?? '', // Default to empty string if null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'flag': flag,
      'message': message,
    };
  }
}
