class OrderDetails {
  InventorySenderDetails senderDetails;
  InventoruyReceiverDetails receiverDetails;
  DateTime receivingDateTime;
  DateTime leavingDateTime;
  int orderSize;
  double inventoryFee;
  String description;

  OrderDetails({
    required this.senderDetails,
    required this.receiverDetails,
    required this.receivingDateTime,
    required this.leavingDateTime,
    required this.orderSize,
    required this.inventoryFee,
    required this.description,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      senderDetails: InventorySenderDetails.fromJson(json['senderDetails']),
      receiverDetails: InventoruyReceiverDetails.fromJson(json['receiverDetails']),
      receivingDateTime: DateTime.parse(json['receivingDateTime']),
      leavingDateTime: DateTime.parse(json['leavingDateTime']),
      orderSize: json['orderSize'],
      inventoryFee: json['inventoryFee'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {
        'senderDetails': senderDetails.toJson(),
        'receiverDetails': receiverDetails.toJson(),
        'receivingDateTime': receivingDateTime.toIso8601String(),
        'leavingDateTime': leavingDateTime.toIso8601String(),
        'orderSize': orderSize,
        'inventoryFee': inventoryFee,
        'description': description,
      };
}

class InventorySenderDetails {
  String name;
  String mobileNumber;
  String addressID;
  double latitude;
  double longitude;

  InventorySenderDetails({
    required this.name,
    required this.mobileNumber,
    required this.addressID,
    required this.latitude,
    required this.longitude,
  });

  factory InventorySenderDetails.fromJson(Map<String, dynamic> json) {
    return InventorySenderDetails(
      name: json['name'],
      mobileNumber: json['mobileNumber'],
      addressID: json['addressID'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'mobileNumber': mobileNumber,
        'addressID': addressID,
        'latitude': latitude,
        'longitude': longitude,
      };
}

class InventoruyReceiverDetails extends InventorySenderDetails {
  String message;

  InventoruyReceiverDetails({
    required String name,
    required String mobileNumber,
    required String addressID,
    required double latitude,
    required double longitude,
    required this.message,
  }) : super(
            name: name,
            mobileNumber: mobileNumber,
            addressID: addressID,
            latitude: latitude,
            longitude: longitude);

  factory InventoruyReceiverDetails.fromJson(Map<String, dynamic> json) {
    return InventoruyReceiverDetails(
      name: json['name'],
      mobileNumber: json['mobileNumber'],
      addressID: json['addressID'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      message: json['message'],
    );
  }

  @override
  Map<String, dynamic> toJson() => super.toJson()..addAll({'message': message});
}
