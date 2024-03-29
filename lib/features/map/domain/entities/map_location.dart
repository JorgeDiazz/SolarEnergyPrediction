import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Represents a selected map location
class MapLocation {
  final String country;
  final String city;
  final LatLng coordinates;

  MapLocation({
    required this.country,
    required this.city,
    required this.coordinates,
  });
}
