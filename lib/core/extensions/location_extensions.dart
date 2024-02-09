import 'package:google_maps_flutter/google_maps_flutter.dart';

extension LocationExtension on LatLng {
  bool isDefaultPoint() {
    return longitude == 0 && latitude == 0;
  }
}
