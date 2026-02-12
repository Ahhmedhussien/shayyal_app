import 'dart:convert';

import 'package:flutter/material.dart';

class PlaceOrder {
  final SenderDetails senderDetails;
  final ReceiverDetails receiverDetails;
  final int vehicleType;
  final double totalDestination;
  final String description;

  PlaceOrder({
    required this.senderDetails,
    required this.receiverDetails,
    required this.vehicleType,
    required this.totalDestination,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
        "senderDetails": senderDetails.toJson(),
        "receiverDetails": receiverDetails.toJson(),
        "veichleType": vehicleType,
        "totalDestination": totalDestination,
        "description": description,
      };
}

class SenderDetails {
  final String name;
  final String mobileNumber;
  final String address;
  final DateTime date;
  final TimeOfDay time;
  final int packageWeight;

  SenderDetails({
    required this.name,
    required this.mobileNumber,
    required this.address,
    required this.date,
    required this.time,
    required this.packageWeight,
  });

  String timeOfDayToString(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  Map<String, dynamic> toJson() {
    String formatDurationToTimeSpan(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      String hours = twoDigits(duration.inHours);
      String minutes = twoDigits(duration.inMinutes.remainder(60));
      String seconds = twoDigits(duration.inSeconds.remainder(60));
      return "$hours:$minutes:$seconds";
    }

    Duration duration = Duration(hours: time.hour, minutes: time.minute);

    return {
      'name': name,
      'mobileNumber': mobileNumber,
      'address': address,
      'date':
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      'time': formatDurationToTimeSpan(duration),
      'packageWeight': packageWeight,
    };
  }
}

class ReceiverDetails {
  final String name;
  final String mobileNumber;
  final String address;
  final String message;

  ReceiverDetails({
    required this.name,
    required this.mobileNumber,
    required this.address,
    required this.message,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "mobileNumber": mobileNumber,
        "address": address,
        "message": message,
      };
}
