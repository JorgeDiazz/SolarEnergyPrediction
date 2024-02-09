import 'package:location/location.dart';

class PermissionsManager {
  static Future<bool> requestLocationPermission(Location location) async {
    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }

    return true;
  }
}
