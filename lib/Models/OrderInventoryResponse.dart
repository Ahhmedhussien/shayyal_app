class OrderInventoryResponseModel {
  final String senderAddressID;
  final String receiverAddressID;
  final String receiverName;
  final String senderName;
  final String senderPhone;
  final String receiverPhone;
  final double orderCost;
  final double appFee;
  final double totalCost;
  final String orderId;
  final int orderSize;
  final String sendingDriverPhoneNo;
  final String description;

  OrderInventoryResponseModel({
    required this.senderAddressID,
    required this.receiverAddressID,
    required this.receiverName,
    required this.senderName,
    required this.senderPhone,
    required this.receiverPhone,
    required this.orderCost,
    required this.appFee,
    required this.totalCost,
    required this.orderId,
    required this.orderSize,
    required this.sendingDriverPhoneNo,
    required this.description,
  });

  factory OrderInventoryResponseModel.fromJson(Map<String, dynamic> json) {
    return OrderInventoryResponseModel(
      senderAddressID: json['senderAddressID'],
      receiverAddressID: json['receiverAddressID'],
      receiverName: json['receiverName'],
      senderName: json['senderName'],
      senderPhone: json['senderPhone'],
      receiverPhone: json['receiverPhone'],
      orderCost: json['orderCost'],
      appFee: json['appFee'],
      totalCost: json['totalCost'],
      orderId: json['orderId'],
      orderSize: json['orderSize'],
      sendingDriverPhoneNo: json['sendingDriverPhoneNo'],
      description: json['description'],
    );
  }
}
