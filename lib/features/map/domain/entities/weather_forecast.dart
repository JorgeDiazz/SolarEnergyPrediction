import 'package:solar_energy_prediction/features/map/domain/entities/map_location.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/weather.dart';

class WeatherForecast {
  final MapLocation mapLocation;
  final List<Weather> weatherList;

  WeatherForecast({
    required this.mapLocation,
    required this.weatherList,
  });
}
