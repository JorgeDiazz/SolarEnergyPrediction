import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mockito/mockito.dart';
import 'package:solar_energy_prediction/core/config/l10n/l10n.dart';
import 'package:solar_energy_prediction/core/errors/failures.dart';
import 'package:solar_energy_prediction/core/extensions/location_extensions.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/map_location.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/temperature.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/weather.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/weather_data.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/weather_forecast.dart';
import 'package:solar_energy_prediction/features/map/presentation/view_models/map/map_view_model.dart';

import '../mocks/view_models_mock_helper.mocks.dart';

void main() {
  final location = MockLocation();
  final getWeatherDataUseCase = MockGetWeatherDataUseCase();
  final getWeather5DaysForecastUseCase = MockGetWeather5DaysForecastUseCase();

  late MapViewModel viewModel;

  setUpAll(() async {
    await S.load(const Locale('en', 'US'));
  });

  setUp(() {
    viewModel = MapViewModel(
      location: location,
      getWeatherDataUseCase: getWeatherDataUseCase,
      getWeather5DaysForecastUseCase: getWeather5DaysForecastUseCase,
    );
  });

  group('#updateLastKnownLocation', () {
    test('''GIVEN a location
    WHEN updateLastKnownLocation is called
    THEN lastKnownLocation state gets updated''', () async {
      // GIVEN
      final locationData =
          LocationData.fromMap({'latitude': 4.123, 'longitude': 72.456});

      when(location.getLocation()).thenAnswer((_) async => locationData);

      // WHEN
      await viewModel.updateLastKnownLocation();

      // THEN
      expect(viewModel.lastKnownLocation.latitude, locationData.latitude);
      expect(viewModel.lastKnownLocation.longitude, locationData.longitude);
    });
  });

  group('#updateSelectedLocation', () {
    test('''GIVEN a location
    WHEN updateSelectedLocation is called
    THEN selectedLocation state gets updated''', () async {
      // GIVEN
      const location = LatLng(44.34, 10.99);

      // WHEN
      viewModel.updateSelectedLocation(location);

      // THEN
      expect(viewModel.selectedLocation, location);
    });
  });

  group('#clearSelectedLocation', () {
    test('''GIVEN an intent to clear location data
    WHEN clearSelectedLocation is called
    THEN selectedLocation, mapLocationData, and weatherForecast states gets cleared''',
        () {
      // GIVEN, WHEN
      viewModel.clearSelectedLocation();

      // THEN
      expect(viewModel.selectedLocation.isDefaultPoint(), isTrue);
      expect(viewModel.weatherData, isNull);
      expect(viewModel.weatherForecast, isNull);
    });
  });

  group('#getCurrentWeatherData', () {
    test('''GIVEN a location
    WHEN getCurrentWeatherData is called
    THEN weatherData state gets updated''', () async {
      // GIVEN
      const location = LatLng(44.34, 10.99);
      final weatherData = _getWeatherDataMock();

      when(getWeatherDataUseCase(location))
          .thenAnswer((_) async => Right(weatherData));

      // WHEN
      await viewModel.getCurrentWeatherData(location);

      // THEN
      expect(viewModel.weatherData, weatherData);
    });

    test('''GIVEN a location
    WHEN getCurrentWeatherData is called and and exception is thrown
    THEN weatherData does not get updated''', () async {
      // GIVEN
      const location = LatLng(44.34, 10.99);

      final serverFailure = ServerFailure(message: 'message', statusCode: -1);

      when(getWeatherDataUseCase(location))
          .thenAnswer((_) async => Left(serverFailure));

      // WHEN
      await viewModel.getCurrentWeatherData(location);

      // THEN
      expect(viewModel.weatherData, isNull);
    });
  });

  group('#getWeather5DaysForecast', () {
    test('''GIVEN a location
    WHEN getWeather5DaysForecast is called
    THEN weatherForecast state gets updated''', () async {
      // GIVEN
      const location = LatLng(44.34, 10.99);
      final weatherForecast = _getWeatherForecastMock();

      when(getWeather5DaysForecastUseCase(location))
          .thenAnswer((_) async => Right(weatherForecast));

      // WHEN
      await viewModel.getWeather5DaysForecast(location);

      // THEN
      expect(viewModel.weatherForecast, weatherForecast);
    });

    test('''GIVEN a location
    WHEN getWeather5DaysForecast is called and and exception is thrown
    THEN weatherForecast does not get updated''', () async {
      // GIVEN
      const location = LatLng(44.34, 10.99);

      final serverFailure = ServerFailure(message: 'message', statusCode: -1);

      when(getWeather5DaysForecastUseCase(location))
          .thenAnswer((_) async => Left(serverFailure));

      // WHEN
      await viewModel.getWeather5DaysForecast(location);

      // THEN
      expect(viewModel.weatherForecast, isNull);
    });
  });

  group('#fetchMapLocationData', () {
    test('''GIVEN a location
    WHEN fetchMapLocationData is called
    THEN weatherData and weatherForecast state gets updated''', () async {
      // GIVEN
      const location = LatLng(44.34, 10.99);

      final weatherData = _getWeatherDataMock();
      when(getWeatherDataUseCase(location))
          .thenAnswer((_) async => Right(weatherData));

      final weatherForecast = _getWeatherForecastMock();
      when(getWeather5DaysForecastUseCase(location))
          .thenAnswer((_) async => Right(weatherForecast));

      // WHEN
      await viewModel.fetchMapLocationData(location);

      // THEN
      expect(viewModel.weatherData, weatherData);
      expect(viewModel.weatherForecast, weatherForecast);
    });
  });
}

WeatherData _getWeatherDataMock() => WeatherData(
      mapLocation: MapLocation(
        country: 'country',
        city: 'city',
        coordinates: const LatLng(0, 0),
      ),
      weather: Weather(
        timestamp: 0,
        temperature: Temperature(average: 0, max: 0, min: 0),
        description: 'description',
        iconUrl: 'iconUrl',
      ),
    );

WeatherForecast _getWeatherForecastMock() => WeatherForecast(
      mapLocation: MapLocation(
        country: 'country',
        city: 'city',
        coordinates: const LatLng(0, 0),
      ),
      weatherList: [
        Weather(
          timestamp: 0,
          temperature: Temperature(average: 0, max: 0, min: 0),
          description: 'description',
          iconUrl: 'iconUrl',
        ),
      ],
    );
