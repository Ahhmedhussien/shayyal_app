class OrderResponse {
  final String senderAddress;
  final String receiverAddress;
  final String senderPhone;
  final String receiverPhone;
  final String senderName;
  final String receiverName;
  final double orderCost;
  final double appFee;
  final double totalCost;
  final String orderId;
  final int packageWeight;
  final String driverId;

  OrderResponse({
    required this.senderAddress,
    required this.receiverAddress,
    required this.senderPhone,
    required this.receiverPhone,
    required this.senderName,
    required this.receiverName,
    required this.orderCost,
    required this.appFee,
    required this.totalCost,
    required this.orderId,
    required this.packageWeight,
    required this.driverId,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      senderAddress: json['senderAddress'],
      receiverAddress: json['receiverAddress'],
      senderPhone: json['senderPhone'],
      receiverPhone: json['receiverPhone'],
      senderName: json['senderName'],
      receiverName: json['receiverName'],
      orderCost: json['orderCost'].toDouble(),
      appFee: json['appFee'].toDouble(),
      totalCost: json['totalCost'].toDouble(),
      orderId: json['orderId'],
      packageWeight: json['packageWeight'],
      driverId: json['driverId'],
    );
  }
}
