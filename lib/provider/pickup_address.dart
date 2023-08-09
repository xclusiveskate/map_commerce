import 'package:flutter/material.dart';

import 'package:map_commerce/models/address_model.dart';

class AppData with ChangeNotifier {
  AddressModel? pickUpAddress;

  updatePickUpAdress(AddressModel pickUp) {
    pickUpAddress = pickUp;
    notifyListeners();
  }
}
