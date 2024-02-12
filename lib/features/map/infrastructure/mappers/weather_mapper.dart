import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:solar_energy_prediction/core/constants/network_constants.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/map_location.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/temperature.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/weather.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/weather_data.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/weather_forecast.dart';
import 'package:solar_energy_prediction/features/map/infrastructure/models/responses/weather_5_days_forecast_response.dart';
import 'package:solar_energy_prediction/features/map/infrastructure/models/responses/weather_data_response.dart';

/// Mapper from WeatherDataResponse (data layer) to WeatherData (domain layer)
extension WeatherDataExtension on WeatherDataResponse {
  WeatherData toEntity() => WeatherData(
        mapLocation: MapLocation(
          country: sys?.country ?? '',
          city: name ?? '',
          coordinates: LatLng(coord?.lat ?? 0, coord?.lon ?? 0),
        ),
        weather: Weather(
          timestamp: dt ?? 0,
          temperature: Temperature(
            average: main?.temp?.round() ?? 0,
            max: main?.tempMax?.round() ?? 0,
            min: main?.tempMin?.round() ?? 0,
          ),
          description: weather?.first.description ?? '',
          iconUrl:
              '${NetworkConstants.baseUrl}${NetworkConstants.weatherIconEndpoint}/${weather?.first.icon}.png',
        ),
      );
}

/// Mapper from Weather5DaysForecastResponse (data layer) to WeatherForecast (domain layer)
extension WeatherForecastExtension on Weather5DaysForecastResponse {
  WeatherForecast toEntity() => WeatherForecast(
        mapLocation: MapLocation(
          country: city?.country ?? '',
          city: city?.name ?? '',
          coordinates: LatLng(city?.coord?.lat ?? 0, city?.coord?.lon ?? 0),
        ),
        weatherList: list?.toEntity() ?? [],
      );
}

/// Mapper from List<ForecastResponse> (data layer) to List<Weather> (domain layer)
extension ForecastListExtension on List<ForecastResponse> {
  List<Weather> toEntity() => map(
        (forecast) => Weather(
          timestamp: forecast.dt ?? 0,
          temperature: Temperature(
            average: forecast.main?.temp?.round() ?? 0,
            max: forecast.main?.tempMax?.round() ?? 0,
            min: forecast.main?.tempMin?.round() ?? 0,
          ),
          description: forecast.weather?.first.description ?? '',
          iconUrl:
              '${NetworkConstants.baseUrl}${NetworkConstants.weatherIconEndpoint}/${forecast.weather?.first.icon}.png',
        ),
      ).toList();
}
