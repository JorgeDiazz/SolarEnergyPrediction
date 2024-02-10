import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:solar_energy_prediction/core/constants/environment.dart';
import 'package:solar_energy_prediction/core/constants/network_constants.dart';
import 'package:solar_energy_prediction/core/use_cases/use_cases.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/map_location.dart';
import 'package:solar_energy_prediction/features/map/domain/repositories/gps_services/gps_services_repository.dart';
import 'package:solar_energy_prediction/features/map/domain/repositories/map/map_location_repository.dart';
import 'package:solar_energy_prediction/features/map/domain/use_cases/gps_services/is_gps_service_enabled_use_case.dart';
import 'package:solar_energy_prediction/features/map/domain/use_cases/gps_services/request_gps_service_use_case.dart';
import 'package:solar_energy_prediction/features/map/domain/use_cases/map/get_map_location_data_use_case.dart';
import 'package:solar_energy_prediction/features/map/infrastructure/datasources/map_location_datasource.dart';
import 'package:solar_energy_prediction/features/map/infrastructure/datasources/map_location_datasource_impl.dart';
import 'package:solar_energy_prediction/features/map/infrastructure/repositories/gps_services/gps_services_repository_impl.dart';
import 'package:solar_energy_prediction/features/map/infrastructure/repositories/map/map_location_repository_impl.dart';

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
    ..registerLazySingleton<MapLocationDatasource>(
      () => MapLocationDatasourceImpl(
        dio: serviceLocator<Dio>(),
      ),
    )
    ..registerLazySingleton<MapLocationRepository>(
      () => MapLocationRepositoryImpl(
        remoteDatasource: serviceLocator<MapLocationDatasource>(),
      ),
    )
    ..registerLazySingleton<
        FutureUseCase<MapLocationData, Tuple2<LatLng, DateTime>>>(
      () => GetMapLocationDataUseCase(
        serviceLocator<MapLocationRepository>(),
      ),
    );
}
