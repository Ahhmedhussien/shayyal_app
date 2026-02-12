// import 'package:firebase_database/firebase_database.dart';
// import 'package:geolocator/geolocator.dart';

// class LocationService {
//   final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

//   Stream<Position> getDriverLocationStream(String driverId) {
//     return _dbRef.child('driverLocations/$driverId').onValue.map((event) {
//       final data = event.snapshot.value as Map<dynamic, dynamic>;
      
//       return Position(
//           latitude: double.parse(data['latitude'].toString()),
//           longitude: double.parse(data['longitude'].toString()),
//           timestamp: DateTime.fromMillisecondsSinceEpoch(data['timestamp']),
//           accuracy:
//               0.0, // Default value, adjust if actual accuracy is available
//           altitude: 0.0, // Default value
//           altitudeAccuracy: 0.0, // Default value
//           heading: 0.0, // Default value
//           headingAccuracy: 0.0, // Default value
//           speed: 0.0, // Default value
//           speedAccuracy: 0.0, // Default value
//           floor: null, // Default value
//           isMocked: false // Default value
//           );
      
//     });
//   }

  

//   Future<void> requestPermissionAndStartTracking(String driverId) async {
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         throw Exception('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       throw Exception(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     if (!await Geolocator.isLocationServiceEnabled()) {
//       throw Exception('Location services are disabled.');
//     }

//     // Start tracking
//     startTracking(driverId);
//   }

//   void startTracking(String driverId) {
//     Geolocator.getPositionStream().listen((Position position) {
//       updateDriverLocation(
//         driverId,
//         position.latitude,
//         position.longitude,
//       );
//     });
//   }

//   Future<void> updateDriverLocation(
//       String driverId, double lat, double lon) async {
//     await _dbRef.child('driverLocations/$driverId').set({
//       'latitude': lat,
//       'longitude': lon,
//       'timestamp': ServerValue.timestamp,
//     });
//   }
// }
