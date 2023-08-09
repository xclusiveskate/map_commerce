import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressModel {
  final String placeId;
  final LatLng latitude;
  final LatLng longitude;
  final String placeAddress;

  AddressModel(
      {required this.placeId,
      required this.longitude,
      required this.latitude,
      required this.placeAddress});
}
