import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:solar_energy_prediction/core/constants/environment.dart';
import 'package:solar_energy_prediction/core/constants/network_constants.dart';
import 'package:solar_energy_prediction/core/constants/weather_constants.dart';
import 'package:solar_energy_prediction/core/use_cases/use_cases.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/weather_data.dart';
import 'package:solar_energy_prediction/features/map/domain/repositories/gps_services/gps_services_repository.dart';
import 'package:solar_energy_prediction/features/map/domain/repositories/map/weather_repository.dart';
import 'package:solar_energy_prediction/features/map/domain/use_cases/gps_services/is_gps_service_enabled_use_case.dart';
import 'package:solar_energy_prediction/features/map/domain/use_cases/gps_services/request_gps_service_use_case.dart';
import 'package:solar_energy_prediction/features/map/domain/use_cases/map/get_weather_data_use_case.dart';
import 'package:solar_energy_prediction/features/map/infrastructure/datasources/weather_datasource.dart';
import 'package:solar_energy_prediction/features/map/infrastructure/datasources/weather_datasource_impl.dart';
import 'package:solar_energy_prediction/features/map/infrastructure/repositories/gps_services/gps_services_repository_impl.dart';
import 'package:solar_energy_prediction/features/map/infrastructure/repositories/map/weather_repository_impl.dart';

final serviceLocator = GetIt.instance;

Future<void> initServiceLocator() async {
  await _initNetworkServices();
  await _initDependencies();
}

Future<void> _initNetworkServices() async {
  serviceLocator.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: NetworkConstants.baseUrl,
        queryParameters: {
          'appid': Environment.openWeatherMapKey,
          'units': WeatherConstants.celsiusSystem,
        },
      ),
    ),
  );
}

Future<void> _initDependencies() async {
  serviceLocator
    ..registerLazySingleton<Location>(
      () => Location(),
    )
    ..registerLazySingleton<GpsServicesRepository>(
      () => GpsServicesRepositoryImpl(
        location: serviceLocator<Location>(),
      ),
    )
    ..registerLazySingleton<FutureUseCase<bool, void>>(
      () => IsGpsServiceEnabledUseCase(
        serviceLocator<GpsServicesRepository>(),
      ),
      instanceName: '$IsGpsServiceEnabledUseCase',
    )
    ..registerLazySingleton<FutureUseCase<bool, void>>(
      () => RequestGpsServiceUseCase(
        serviceLocator<GpsServicesRepository>(),
      ),
      instanceName: '$RequestGpsServiceUseCase',
    )
    ..registerLazySingleton<WeatherDatasource>(
      () => WeatherDatasourceImpl(
        dio: serviceLocator<Dio>(),
      ),
    )
    ..registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(
        remoteDatasource: serviceLocator<WeatherDatasource>(),
      ),
    )
    ..registerLazySingleton<FutureUseCase<WeatherData, LatLng>>(
      () => GetWeatherDataUseCase(
        serviceLocator<WeatherRepository>(),
      ),
    );
}
