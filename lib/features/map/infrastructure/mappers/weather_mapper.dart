import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:solar_energy_prediction/core/constants/network_constants.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/map_location.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/temperature.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/weather.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/weather_data.dart';
import 'package:solar_energy_prediction/features/map/infrastructure/models/responses/weather_data_response.dart';

extension WeatherDataExtension on WeatherDataResponse {
  WeatherData toEntity() => WeatherData(
        mapLocation: MapLocation(
          country: sys?.country ?? '',
          city: name ?? '',
          coordinates: LatLng(coord?.lat ?? 0, coord?.lon ?? 0),
        ),
        weather: Weather(
          temperature: Temperature(
            average: main?.temp ?? 0,
            max: main?.tempMax ?? 0,
            min: main?.tempMin ?? 0,
          ),
          description: weather?.first.description ?? '',
          iconUrl:
              '${NetworkConstants.baseUrl}${NetworkConstants.weatherIconEndpoint}/${weather?.first.icon}.png',
        ),
      );
}
