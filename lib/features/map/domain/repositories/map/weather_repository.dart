import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:solar_energy_prediction/core/utils/typedefs.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/weather_data.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/weather_forecast.dart';

abstract class WeatherRepository {
  ResultFuture<WeatherData> getWeatherData({required LatLng location});

  ResultFuture<WeatherForecast> getWeather5DaysForecast(
      {required LatLng location});
}
