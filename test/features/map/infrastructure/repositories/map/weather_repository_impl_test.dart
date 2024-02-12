import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:solar_energy_prediction/core/errors/exceptions.dart';
import 'package:solar_energy_prediction/core/errors/failures.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/weather_data.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/weather_forecast.dart';
import 'package:solar_energy_prediction/features/map/domain/repositories/map/weather_repository.dart';
import 'package:solar_energy_prediction/features/map/infrastructure/datasources/weather_datasource.dart';
import 'package:solar_energy_prediction/features/map/infrastructure/models/responses/weather_5_days_forecast_response.dart';
import 'package:solar_energy_prediction/features/map/infrastructure/models/responses/weather_data_response.dart';
import 'package:solar_energy_prediction/features/map/infrastructure/repositories/map/weather_repository_impl.dart';

import '../mocks/repositories_mock_helper.mocks.dart';

void main() async {
  final WeatherDatasource remoteDatasource = MockWeatherDatasource();

  late WeatherRepository repository;

  setUpAll(() async {
    repository = WeatherRepositoryImpl(
      remoteDatasource: remoteDatasource,
    );
  });

  group('#getWeatherData', () {
    test('''GIVEN a location 
  WHEN #getWeatherData is called
  THEN a WeatherData instance is returned''', () async {
      // GIVEN
      const location = LatLng(44.34, 10.99);

      final weatherDataResponse = WeatherDataResponse(
        coord: CoordResponse(
          lat: location.latitude,
          lon: location.longitude,
        ),
      );

      when(remoteDatasource.fetchWeatherData(location))
          .thenAnswer((_) async => weatherDataResponse);

      // WHEN
      final result = await repository.getWeatherData(location: location);

      // THEN
      expect(result, isA<Right<Failure, WeatherData>>());
    });

    test('''GIVEN a location 
  WHEN #getWeatherData is called and it throws a ServerException
  THEN a ServerFailure is returned''', () async {
      // GIVEN
      const location = LatLng(44.34, 10.99);

      const exception = ServerException(
        message: 'message',
        statusCode: -1,
      );

      when(remoteDatasource.fetchWeatherData(location)).thenThrow(exception);

      // WHEN
      final result = await repository.getWeatherData(location: location);

      // THEN
      expect(
        result,
        isA<Left<Failure, WeatherData>>().having(
          (f) => f.value.message,
          'error message',
          exception.message,
        ),
      );
    });
  });

  group('#getWeather5DaysForecast', () {
    test('''GIVEN a location 
  WHEN #getWeather5DaysForecast is called
  THEN a WeatherForecast instance is returned''', () async {
      // GIVEN
      const location = LatLng(44.34, 10.99);

      final weatherForecastResponse = Weather5DaysForecastResponse(
        city: City(
          coord: Coord(lat: location.latitude, lon: location.longitude),
        ),
      );

      when(remoteDatasource.fetchWeather5DaysForecast(location))
          .thenAnswer((_) async => weatherForecastResponse);

      // WHEN
      final result =
          await repository.getWeather5DaysForecast(location: location);

      // THEN
      expect(result, isA<Right<Failure, WeatherForecast>>());
    });

    test('''GIVEN a location 
  WHEN #getWeather5DaysForecast is called and it throws a ServerException
  THEN a ServerFailure is returned''', () async {
      // GIVEN
      const location = LatLng(44.34, 10.99);

      const exception = ServerException(
        message: 'message',
        statusCode: -1,
      );

      when(remoteDatasource.fetchWeather5DaysForecast(location))
          .thenThrow(exception);

      // WHEN
      final result =
          await repository.getWeather5DaysForecast(location: location);

      // THEN
      expect(
        result,
        isA<Left<Failure, WeatherForecast>>().having(
          (f) => f.value.message,
          'error message',
          exception.message,
        ),
      );
    });
  });
}
