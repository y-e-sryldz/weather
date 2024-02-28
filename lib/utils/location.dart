import 'dart:ffi';

import 'package:location/location.dart';

class LocationHelper {
  late double latitude;
  late double longitude;

  Future<void> getCurrentLocation() async {
    Location location = Location();

    bool _serviceaEnabled;
    PermissionStatus _permissonGranted;
    LocationData _locationData;

    //Location için servis ayaktamı
    _serviceaEnabled = await location.serviceEnabled();
    if (!_serviceaEnabled) {
      _serviceaEnabled = await location.requestService();
      if (!_serviceaEnabled) {
        return;
      }
    }

    //konum izin kontrolü
    _permissonGranted = await location.hasPermission();
    if (_permissonGranted == PermissionStatus.denied) {
      _permissonGranted = await location.requestPermission();
      if (_permissonGranted != PermissionStatus.granted) {
        return;
      }
    }

    //izinler tamamsa
    _locationData = await location.getLocation();
    latitude = _locationData.latitude!;
    longitude = _locationData.longitude!;
  }

}
