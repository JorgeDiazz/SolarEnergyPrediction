import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:solar_energy_prediction/core/errors/failures.dart';
import 'package:solar_energy_prediction/core/use_cases/use_cases.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/map_location.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/temperature.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/weather.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/weather_data.dart';
import 'package:solar_energy_prediction/features/map/domain/repositories/map/weather_repository.dart';
import 'package:solar_energy_prediction/features/map/domain/use_cases/weather/get_weather_data_use_case.dart';

import '../mocks/use_cases_mock_helper.mocks.dart';

void main() async {
  final WeatherRepository repository = MockWeatherRepository();

  late FutureUseCase<WeatherData, LatLng> useCase;

  setUpAll(() async {
    useCase = GetWeatherDataUseCase(repository);
  });

  test('''GIVEN a location 
  WHEN use case is called
  THEN an instance of WeatherData is returned''', () async {
    // GIVEN
    const location = LatLng(44.34, 10.99);

    final weatherData = _getWeatherDataMock();

    when(repository.getWeatherData(location: location)).thenAnswer(
      (_) async => Right(weatherData),
    );

    // WHEN
    final result = await useCase(location);

    // THEN
    expect(result, Right<dynamic, WeatherData>(weatherData));
  });

  test('''GIVEN an location 
  WHEN use case is called and it throws a ServerFailure
  THEN a ServerFailure is returned''', () async {
    // GIVEN
    const location = LatLng(44.34, 10.99);

    final failure = ServerFailure(
      message: 'message',
      statusCode: -1,
    );

    when(repository.getWeatherData(location: location)).thenAnswer(
      (_) async => Left(failure),
    );

    // WHEN
    final result = await useCase(location);

    // THEN
    expect(
      result,
      isA<Left<Failure, WeatherData>>().having(
        (f) => f.value.message,
        'error message',
        failure.message,
      ),
    );
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
