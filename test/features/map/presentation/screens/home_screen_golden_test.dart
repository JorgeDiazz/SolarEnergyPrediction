import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mockito/mockito.dart';
import 'package:solar_energy_prediction/core/config/l10n/l10n.dart';
import 'package:solar_energy_prediction/core/service_locator/service_locator.dart';
import 'package:solar_energy_prediction/core/use_cases/use_cases.dart';
import 'package:solar_energy_prediction/core/utils/test_config.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/weather_data.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/weather_forecast.dart';
import 'package:solar_energy_prediction/features/map/domain/use_cases/gps_services/is_gps_service_enabled_use_case.dart';
import 'package:solar_energy_prediction/features/map/domain/use_cases/gps_services/request_gps_service_use_case.dart';
import 'package:solar_energy_prediction/features/map/presentation/screens/home_screen.dart';

import '../../../../utils/test_devices.dart';
import '../utils/ui_utils.dart';
import '../view_models/mocks/view_models_mock_helper.mocks.dart';

void main() {
  final location = MockLocation();
  final getWeatherDataUseCase = MockGetWeatherDataUseCase();
  final getWeather5DaysForecastUseCase = MockGetWeather5DaysForecastUseCase();
  final isGpsServiceEnabledUseCase = MockIsGpsServiceEnabledUseCase();
  final requestGpsServiceUseCase = MockRequestGpsServiceUseCase();

  setUpAll(() async {
    TestConfig.inTestMode = true;

    await S.load(const Locale('en', 'US'));

    serviceLocator
      ..pushNewScope()
      ..registerLazySingleton<Location>(
        () => location,
      )
      ..registerLazySingleton<FutureUseCase<WeatherData, LatLng>>(
        () => getWeatherDataUseCase,
      )
      ..registerLazySingleton<FutureUseCase<WeatherForecast, LatLng>>(
        () => getWeather5DaysForecastUseCase,
      )
      ..registerLazySingleton<FutureUseCase<bool, void>>(
        () => isGpsServiceEnabledUseCase,
        instanceName: '$IsGpsServiceEnabledUseCase',
      )
      ..registerLazySingleton<FutureUseCase<bool, void>>(
        () => requestGpsServiceUseCase,
        instanceName: '$RequestGpsServiceUseCase',
      );
  });

  tearDownAll(() => serviceLocator.popScope());

  group('GIVEN HomeScreen', () {
    group('WHEN permissions have not been granted', () {
      testGoldens('THEN request GPS services view is rendered',
          (WidgetTester tester) async {
        // GIVEN
        when(location.hasPermission())
            .thenAnswer((_) async => PermissionStatus.denied);
        when(location.requestPermission())
            .thenAnswer((_) async => PermissionStatus.denied);
        when(isGpsServiceEnabledUseCase(null))
            .thenAnswer((_) async => const Right(false));
        when(requestGpsServiceUseCase(null))
            .thenAnswer((_) async => const Right(false));

        await tester.pumpWidget(
          buildLocalizedAppWidget(
            const HomeScreen(),
          ),
        );

        // WHEN, THEN
        await multiScreenGolden(
          tester,
          'home_screen_request_gps_services',
          devices: TestDevices.iosDevices,
        );
      });
    });

    group('WHEN permissions have been granted', () {
      testGoldens('THEN map view is rendered', (WidgetTester tester) async {
        // GIVEN
        final locationData =
            LocationData.fromMap({'latitude': 0.0, 'longitude': 0.0});

        when(location.hasPermission())
            .thenAnswer((_) async => PermissionStatus.granted);
        when(location.requestPermission())
            .thenAnswer((_) async => PermissionStatus.granted);
        when(location.getLocation()).thenAnswer((_) async => locationData);
        when(isGpsServiceEnabledUseCase(null))
            .thenAnswer((_) async => const Right(true));
        when(requestGpsServiceUseCase(null))
            .thenAnswer((_) async => const Right(true));

        await tester.pumpWidget(
          buildLocalizedAppWidget(
            const HomeScreen(),
          ),
        );

        // WHEN, THEN
        await multiScreenGolden(
          tester,
          'home_screen_map',
          devices: TestDevices.iosDevices,
        );
      });
    });
  });
}
