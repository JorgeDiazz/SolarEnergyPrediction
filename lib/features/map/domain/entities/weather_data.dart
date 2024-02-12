import 'package:solar_energy_prediction/features/map/domain/entities/map_location.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/weather.dart';

/// Represents the main entity of the app
class WeatherData {
  final MapLocation mapLocation;
  final Weather weather;

  WeatherData({
    required this.mapLocation,
    required this.weather,
  });
}
