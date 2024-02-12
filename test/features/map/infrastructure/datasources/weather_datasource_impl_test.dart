import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:solar_energy_prediction/core/constants/network_constants.dart';
import 'package:solar_energy_prediction/core/errors/exceptions.dart';
import 'package:solar_energy_prediction/features/map/infrastructure/datasources/weather_datasource.dart';
import 'package:solar_energy_prediction/features/map/infrastructure/datasources/weather_datasource_impl.dart';

import 'mocks/datasources_mock_helper.mocks.dart';
import 'utils/json_reader.dart';

void main() async {
  final Dio mockDio = MockDio();

  late WeatherDatasource remoteDatasource;

  setUpAll(() async {
    remoteDatasource = WeatherDatasourceImpl(
      dio: mockDio,
    );
  });

  group('#fetchWeatherData', () {
    test('''GIVEN a location 
  WHEN #fetchWeatherData is called
  THEN current weather data is returned''', () async {
      // GIVEN
      const location = LatLng(44.34, 10.99);

      _setUpDioGetStubs(
        mockDio: mockDio,
        endpoint: NetworkConstants.currentWeatherDataEndpoint,
        statusCode: HttpStatus.ok,
        jsonResponseFileName: 'fake_current_weather_data_response.json',
      );

      // WHEN
      final weatherDataResponse =
          await remoteDatasource.fetchWeatherData(location);

      // THEN
      expect(weatherDataResponse.coord?.lat, location.latitude);
      expect(weatherDataResponse.coord?.lon, location.longitude);
      expect(weatherDataResponse.weather, isNotNull);
    });

    test('''GIVEN a location 
  WHEN #fetchWeatherData is called and data response is null
  THEN ServerException is thrown ''', () async {
      // GIVEN
      const location = LatLng(44.34, 10.99);

      _setUpDioGetStubs(
        mockDio: mockDio,
        endpoint: NetworkConstants.currentWeatherDataEndpoint,
        statusCode: HttpStatus.httpVersionNotSupported,
        jsonResponseFileName: null,
      );

      // WHEN, THEN
      expect(
        remoteDatasource.fetchWeatherData(location),
        throwsA(
          const TypeMatcher<ServerException>().having(
            (e) => e.statusCode,
            'status code',
            HttpStatus.httpVersionNotSupported,
          ),
        ),
      );
    });

    test('''GIVEN a location 
  WHEN #fetchWeatherData is called and an error occurred
  THEN ServerException is thrown''', () async {
      // GIVEN
      const location = LatLng(44.34, 10.99);

      _setUpErrorDioStubs(
        mockDio: mockDio,
        endpoint: NetworkConstants.currentWeatherDataEndpoint,
      );

      // WHEN, THEN
      expect(
        remoteDatasource.fetchWeatherData(location),
        throwsA(
          const TypeMatcher<ServerException>().having(
            (e) => e.statusCode,
            'status code',
            HttpStatus.httpVersionNotSupported,
          ),
        ),
      );
    });
  });

  group('#fetchWeather5DaysForecast', () {
    test('''GIVEN a location 
  WHEN #fetchWeather5DaysForecast is called
  THEN weather 5 days forecast is returned''', () async {
      // GIVEN
      const location = LatLng(44.34, 10.99);

      _setUpDioGetStubs(
        mockDio: mockDio,
        endpoint: NetworkConstants.weather5DaysForecastEndpoint,
        statusCode: HttpStatus.ok,
        jsonResponseFileName: 'fake_weather_5_days_forecast_response.json',
      );

      // WHEN
      final weatherForecastResponse =
          await remoteDatasource.fetchWeather5DaysForecast(location);

      // THEN
      expect(weatherForecastResponse.city?.coord?.lat, location.latitude);
      expect(weatherForecastResponse.city?.coord?.lon, location.longitude);
      expect(weatherForecastResponse.list, isNotNull);
    });

    test('''GIVEN a location 
  WHEN #fetchWeather5DaysForecast is called and data response is null
  THEN ServerException is thrown ''', () async {
      // GIVEN
      const location = LatLng(44.34, 10.99);

      _setUpDioGetStubs(
        mockDio: mockDio,
        endpoint: NetworkConstants.weather5DaysForecastEndpoint,
        statusCode: HttpStatus.httpVersionNotSupported,
        jsonResponseFileName: null,
      );

      // WHEN, THEN
      expect(
        remoteDatasource.fetchWeather5DaysForecast(location),
        throwsA(
          const TypeMatcher<ServerException>().having(
            (e) => e.statusCode,
            'status code',
            HttpStatus.httpVersionNotSupported,
          ),
        ),
      );
    });

    test('''GIVEN a location 
  WHEN #fetchWeatherData is called and an error occurred
  THEN ServerException is thrown''', () async {
      // GIVEN
      const location = LatLng(44.34, 10.99);

      _setUpErrorDioStubs(
        mockDio: mockDio,
        endpoint: NetworkConstants.weather5DaysForecastEndpoint,
      );

      // WHEN, THEN
      expect(
        remoteDatasource.fetchWeather5DaysForecast(location),
        throwsA(
          const TypeMatcher<ServerException>().having(
            (e) => e.statusCode,
            'status code',
            HttpStatus.httpVersionNotSupported,
          ),
        ),
      );
    });
  });
}

void _setUpErrorDioStubs({
  required Dio mockDio,
  required String endpoint,
}) {
  when(
    mockDio.get(endpoint),
  ).thenThrow(Exception());
}

void _setUpDioGetStubs({
  required Dio mockDio,
  required String endpoint,
  required int statusCode,
  String? jsonResponseFileName,
}) {
  final Map<String, dynamic>? dataMap = jsonResponseFileName == null
      ? null
      : json.decode(
          readJson(
              'features/map/infrastructure/datasources/mocks/json_responses/$jsonResponseFileName'),
        );

  when(
    mockDio.get(endpoint, queryParameters: anyNamed('queryParameters')),
  ).thenAnswer(
    (_) async => Response<dynamic>(
      requestOptions: RequestOptions(path: ''),
      statusCode: statusCode,
      data: dataMap,
    ),
  );
}
