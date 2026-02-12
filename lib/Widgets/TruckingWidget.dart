// import 'package:flutter/material.dart';
// import 'package:shyal/Component/HorizontalTimelineTwoTitle.dart';
// import 'package:shyal/Component/Icon_BackGrounded.dart';
// import 'package:shyal/Models/Orders.dart';
// import 'package:shyal/Services/OrderService.dart';
// import 'package:shyal/const.dart';

// class TrackingWidget extends StatefulWidget {
//   const TrackingWidget({super.key});

//   @override
//   State<TrackingWidget> createState() => _TrackingWidgetState();
// }

// class _TrackingWidgetState extends State<TrackingWidget> {
//   final OrdersService ordersService = OrdersService();
//   late Future<Orders> lastOrder;

//   void fetchLastOrder() {
//     setState(() {
//       lastOrder = ordersService.fetchLastOrder();
//     });
//   }

//   @override
//   void initState() {
//     fetchLastOrder();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//     final padding = screenWidth * 0.04;
//     var iconContainerSize = MediaQuery.of(context).size.width * 0.12;
//     final textSize = screenWidth * 0.04; // Dynamic text size for content

//     return FutureBuilder<Orders>(
//       future: lastOrder,
//       builder: (context, snapshot){

//       },

//       return SingleChildScrollView(
//         child: Card(
//           color: const Color(0xFF1D2623),
//           child: Padding(
//             padding: EdgeInsets.all(padding),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: <Widget>[
//                     Icon_BackGrounded(
//                       color: Secound_background_color,
//                       iconContainerSize: iconContainerSize,
//                       icon: const Icon(
//                         Icons.local_shipping,
//                         color: green_color,
//                       ),
//                     ),
//                     SizedBox(width: screenWidth * 0.02),
//                     Expanded(
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Text(
//                             "",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w900,
//                               fontSize: textSize, // Responsive text size
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           Text(
//                             'Tracking ID : U08765487CE',
//                             style: TextStyle(
//                                 color: Colors.grey, fontSize: textSize),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Icon_BackGrounded(
//                       color: Secound_background_color,
//                       iconContainerSize: iconContainerSize,
//                       icon: const Icon(
//                         Icons.more_vert,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: screenHeight * 0.02),
//                 const Divider(color: Colors.grey),
//                 // Timeline content, dynamically sized
//                 Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     HorizontalTimelineTwoTitle(
//                         context, 'From', '2B Store, El Gomhorya'),
//                     HorizontalTimelineTwoTitle(
//                         context, 'Shipped To', 'Inventory, El Wladya'),
//                   ],
//                 ),
//                 SizedBox(height: screenHeight * 0.04),
//                 const Divider(color: Colors.grey),
//                 Padding(
//                   padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
//                   child: Text(
//                     'Status: Your Package is in transit',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w900,
//                         fontSize: textSize),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:shyal/Component/HorizontalTimelineTwoTitle.dart';
import 'package:shyal/Component/Icon_BackGrounded.dart';
import 'package:shyal/Models/Orders.dart';
import 'package:shyal/Services/OrderService.dart';
import 'package:shyal/const.dart';

class TrackingWidget extends StatefulWidget {
  const TrackingWidget({super.key});

  @override
  State<TrackingWidget> createState() => _TrackingWidgetState();
}

class _TrackingWidgetState extends State<TrackingWidget> {
  final OrdersService ordersService = OrdersService();
  late Future<Orders> lastOrder;

  void fetchLastOrder() {
    setState(() {
      lastOrder = ordersService.fetchLastOrder();
    });
  }

  @override
  void initState() {
    fetchLastOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = screenWidth * 0.04;
    var iconContainerSize = MediaQuery.of(context).size.width * 0.12;
    final textSize = screenWidth * 0.04; // Dynamic text size for content

    return FutureBuilder<Orders>(
      future: lastOrder,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No order found'));
        } else {
          Orders order = snapshot.data!;
          return SingleChildScrollView(
            child: Card(
              color: const Color(0xFF1D2623),
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon_BackGrounded(
                          color: Secound_background_color,
                          iconContainerSize: iconContainerSize,
                          icon: const Icon(
                            Icons.local_shipping,
                            color: green_color,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                order.senderName,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: textSize,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                order.description,
                                style: TextStyle(
                                    color: Colors.grey, fontSize: textSize),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                        // Icon_BackGrounded(
                        //   color: Secound_background_color,
                        //   iconContainerSize: iconContainerSize,
                        //   icon: const Icon(
                        //     Icons.more_vert,
                        //     color: Colors.white,
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    const Divider(color: Colors.grey),
                    // Timeline content, dynamically sized
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        HorizontalTimelineTwoTitle(
                            context, 'From', order.originAddress),
                        HorizontalTimelineTwoTitle(
                            context, 'Shipped To', order.destinationAddress),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    const Divider(color: Colors.grey),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                      child: Text(
                        'Status: ${getStatusText(order.orderStatus)}',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: textSize),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  String getStatusText(int status) {
    switch (status) {
      case 0:
        return 'Pending';
      case 1:
        return 'In Transit';
      case 2:
        return 'Delivered';
      default:
        return 'Unknown';
    }
  }
}
