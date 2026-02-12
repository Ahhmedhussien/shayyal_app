// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:shyal/Component/Icon_BackGrounded.dart';
// import 'package:shyal/Models/OrderResponse.dart';
// import 'package:shyal/const.dart';

// class TrackPackageScreen extends StatefulWidget {
//   final OrderResponse orderResponse;

//   const TrackPackageScreen({super.key, required this.orderResponse});

//   @override
//   State<TrackPackageScreen> createState() => _TrackPackageScreenState();
// }

// class _TrackPackageScreenState extends State<TrackPackageScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final double ScreenHeight = MediaQuery.of(context).size.height;

//     final double ScreenWeight = MediaQuery.of(context).size.width;

//     // Responsive padding
//     final EdgeInsetsGeometry padding =
//         EdgeInsets.all(MediaQuery.of(context).size.width * 0.04);
//     // Responsive spacing
//     final double space = ScreenHeight * 0.02;

//     // Responsive font size
//     final double titlefontsize = ScreenWeight * 0.07;

//     // Determine the size of the icon container dynamically
//     var iconContainerSize = ScreenWeight * 0.12; // e.g., 12% of screen width

//     return Scaffold(
//       backgroundColor: background_color,
//       appBar: AppBar(
//         backgroundColor: background_color,
//         title: const Text('Track Pacakeg'),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pushReplacementNamed(context, '/HomeScreen');
//           },
//         ),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//           child: Padding(
//         padding: EdgeInsets.all(ScreenHeight * 0.02),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 height: ScreenHeight * 0.5,
//                 width: ScreenWeight * 1,
//                 // decoration: BoxDecoration(
//                 //   borderRadius: BorderRadius.circular(12),
//                 //   image: const DecorationImage(
//                 //     image: AssetImage('assets/img/R.png'),
//                 //     fit: BoxFit.cover,
//                 //   ),
//                 // ),
//                 child: FlutterMap(
//                   options: MapOptions(
//           initialCenter: LatLng(
//             (orderResponse. + receiverLocation.latitude) / 2,
//             (senderLocation.longitude + receiverLocation.longitude) / 2,
//           ),
//           zoom: 10.0,
//         ),
//                 ),
//               ),
//               SizedBox(
//                 height: space,
//               ),
//               Text(
//                 'Package Information',
//                 style: TextStyle(
//                     fontSize: titlefontsize,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 height: space,
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   color: Secound_background_color,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: DeliveryTypeWidget(
//                     ScreenHeight: ScreenHeight,
//                     titlefontsize: titlefontsize,
//                     deliverytype: 'Express Delivery',
//                     packageweight: '4 KG'),
//               ),
//               SizedBox(
//                 height: space,
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   color: Secound_background_color,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(ScreenHeight * 0.02),
//                   child: Row(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(
//                             8), // Adjust border radius as needed
//                         child: Image.asset(
//                           'assets/img/AlanWalker.jpg', // Replace with your image URL
//                           width: iconContainerSize, // Adjust width as needed
//                           height: iconContainerSize, // Adjust height as needed
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       SizedBox(
//                         width: space,
//                       ),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Steven Bahaa',
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: titlefontsize * 0.7),
//                             ),
//                             Text(
//                               '01281619077',
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: titlefontsize * 0.7),
//                             ),
//                           ],
//                         ),
//                       ),
//                       // Icon_BackGrounded(
//                       //   iconContainerSize: iconContainerSize,
//                       //   icon: Icon(
//                       //     Icons.phone,
//                       //     color: green_color,
//                       //   ),
//                       // ),
//                       Container(
//                         height: iconContainerSize,
//                         width: iconContainerSize,
//                         decoration: BoxDecoration(
//                             color: Secound_green_color,
//                             borderRadius: BorderRadius.circular(8)),
//                         child: IconButton(
//                           onPressed: () {},
//                           icon: const Icon(
//                             Icons.phone,
//                             color: Colors.white,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       )),
//     );
//   }
// }

// class DeliveryTypeWidget extends StatelessWidget {
//   const DeliveryTypeWidget(
//       {super.key,
//       required this.ScreenHeight,
//       required this.titlefontsize,
//       required this.deliverytype,
//       required this.packageweight});

//   final double ScreenHeight;
//   final double titlefontsize;
//   final String deliverytype;
//   final String packageweight;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Padding(
//           padding: EdgeInsets.all(ScreenHeight * 0.02),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Delivery Type',
//                 style: TextStyle(
//                     color: Colors.grey, fontSize: titlefontsize * 0.5),
//               ),
//               Text(
//                 deliverytype,
//                 style: TextStyle(
//                     color: Colors.white, fontSize: titlefontsize * 0.7),
//               ),
//             ],
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.all(ScreenHeight * 0.02),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Package Weight',
//                 style: TextStyle(
//                     color: Colors.grey, fontSize: titlefontsize * 0.5),
//               ),
//               Text(
//                 packageweight,
//                 style: TextStyle(
//                     color: Colors.white, fontSize: titlefontsize * 0.7),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
