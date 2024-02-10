import 'package:solar_energy_prediction/features/map/domain/entities/map_location.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/weather.dart';

class WeatherData {
  final MapLocation mapLocation;
  final Weather weather;

  WeatherData({
    required this.mapLocation,
    required this.weather,
  });
}
