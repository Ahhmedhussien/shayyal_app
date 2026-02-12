class DriverOrder {
  final String orderId;
  final String driverId;
  final String description;
  final int packageWeight;
  final double orderCost;
  final double appFee;
  final double totalCost;
  final String senderName;
  final String receiverName;
  final String senderPhone;
  final String receiverPhone;
  final String senderAddress;
  final String receiverAddress;

  DriverOrder({
    required this.orderId,
    required this.driverId,
    required this.description,
    required this.packageWeight,
    required this.orderCost,
    required this.appFee,
    required this.totalCost,
    required this.senderName,
    required this.receiverName,
    required this.senderPhone,
    required this.receiverPhone,
    required this.senderAddress,
    required this.receiverAddress,
  });

  factory DriverOrder.fromJson(Map<String, dynamic> json) {
    return DriverOrder(
      orderId: json['orderId'],
      driverId: json['driverId'],
      description: json['description'] ?? "",
      packageWeight: json['packageWeight'],
      orderCost: json['orderCost'],
      appFee: json['appFee'],
      totalCost: json['totalCost'],
      senderName: json['senderName'],
      receiverName: json['receiverName'],
      senderPhone: json['senderPhone'],
      receiverPhone: json['receiverPhone'],
      senderAddress: json['senderAddress'],
      receiverAddress: json['receiverAddress'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'driverId': driverId,
      'description': description,
      'packageWeight': packageWeight,
      'orderCost': orderCost,
      'appFee': appFee,
      'totalCost': totalCost,
      'senderName': senderName,
      'receiverName': receiverName,
      'senderPhone': senderPhone,
      'receiverPhone': receiverPhone,
      'senderAddress': senderAddress,
      'receiverAddress': receiverAddress,
    };
  }
}
