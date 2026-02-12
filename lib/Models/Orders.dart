class Orders {
  final String orderID;
  final String customerID;
  final String driverID;
  final String senderName;
  final String receiverName;
  final String senderPhone;
  final String receiverPhone;
  final String originAddress;
  final String destinationAddress;
  final String description;
  final int orderStatus;
  final int weight;
  final DateTime orderDate;

  Orders({
    required this.orderID,
    required this.customerID,
    required this.driverID,
    required this.senderName,
    required this.receiverName,
    required this.senderPhone,
    required this.receiverPhone,
    required this.originAddress,
    required this.destinationAddress,
    required this.description,
    required this.orderStatus,
    required this.weight,
    required this.orderDate,
  });

  factory Orders.fromJson(Map<String, dynamic> json) {
    return Orders(
      orderID: json['orderID'],
      customerID: json['customerID'],
      driverID: json['driverID'],
      senderName: json['senderName'],
      receiverName: json['receiverName'],
      senderPhone: json['senderPhone'],
      receiverPhone: json['receiverPhone'],
      originAddress: json['originAddress'],
      destinationAddress: json['destinationAddress'],
      description: json['description'] ?? "",
      orderStatus: json['orderStatus'],
      weight: json['weight'],
      orderDate: DateTime.parse(json['orderDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderID': orderID,
      'customerID': customerID,
      'driverID': driverID,
      'senderName': senderName,
      'receiverName': receiverName,
      'senderPhone': senderPhone,
      'receiverPhone': receiverPhone,
      'originAddress': originAddress,
      'destinationAddress': destinationAddress,
      'description': description,
      'orderStatus': orderStatus,
      'weight': weight,
      'orderDate': orderDate.toIso8601String(),
    };
  }
}
