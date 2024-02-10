import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/sky_solar_irradiance.dart';

class MapLocationData {
  final String country;
  final String city;
  final LatLng latLng;
  final SkySolarIrradiance currentSolarIrradiance;
  // final SkySolarIrradiance weekAgoSolarIrradiance;
  // final SkySolarIrradiance monthAgoSolarIrradiance;
  // final List<SkySolarIrradiance> next30DaysSolarIrradiance;

  MapLocationData({
    required this.country,
    required this.city,
    required this.latLng,
    required this.currentSolarIrradiance,
    //  required this.weekAgoSolarIrradiance,
    //  required this.monthAgoSolarIrradiance,
    //  required this.next30DaysSolarIrradiance,
  });
}
