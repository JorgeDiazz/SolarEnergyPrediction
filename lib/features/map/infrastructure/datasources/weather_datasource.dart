import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:solar_energy_prediction/features/map/infrastructure/models/responses/weather_data_response.dart';

abstract class WeatherDatasource {
  Future<WeatherDataResponse> fetchWeatherData(LatLng location);
}
