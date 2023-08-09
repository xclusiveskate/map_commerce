// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'package:geolocator/geolocator.dart';

// class AddressSelectionScreen extends StatefulWidget {
//   @override
//   _AddressSelectionScreenState createState() => _AddressSelectionScreenState();
// }

// class _AddressSelectionScreenState extends State<AddressSelectionScreen> {
//   final TextEditingController addressController = TextEditingController();
//   GoogleMapController? mapController;
//   late LatLng currentLocation;
//   late Marker currentLocationMarker;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize the map with a default position
//     currentLocation = LatLng(37.7749, -122.4194); // Default to San Francisco
//     currentLocationMarker = Marker(
//       markerId: MarkerId('currentLocation'),
//       position: currentLocation,
//       infoWindow: InfoWindow(title: 'Current Location'),
//     );
//   }

//   void useCurrentLocation() async {
//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.best,
//     );
//     setState(() {
//       currentLocation = LatLng(position.latitude, position.longitude);
//       currentLocationMarker = currentLocationMarker.copyWith(
//         positionParam: currentLocation,
//       );
//       mapController?.animateCamera(CameraUpdate.newLatLng(currentLocation));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Address Selection'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             GoogleMap(
//               onMapCreated: (controller) {
//                 mapController = controller;
//                 // mapController?.addMarker(currentLocationMarker);
//               },
//               initialCameraPosition: CameraPosition(
//                 target: currentLocation,
//                 zoom: 15,
//               ),
//               markers: Set<Marker>.from([currentLocationMarker]),
//             ),
//             SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: TextField(
//                 controller: addressController,
//                 decoration: InputDecoration(
//                   labelText: 'Enter Address',
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () {
//                 // Implement your logic for using entered address
//               },
//               child: Text('Use This Address'),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: useCurrentLocation,
//               child: Text('Use My Current Location'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: AddressSelectionScreen(),
//   ));
// }
