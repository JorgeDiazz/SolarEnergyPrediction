import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:solar_energy_prediction/features/map/infrastructure/models/responses/solar_irradiance_response.dart';

abstract class MapLocationDatasource {
  Future<SolarIrradianceResponse> fetchSolarIrradiance(
      LatLng location, DateTime date);
}
