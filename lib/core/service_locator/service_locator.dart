import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:location/location.dart';
import 'package:solar_energy_prediction/core/constants/network_constants.dart';
import 'package:solar_energy_prediction/core/use_cases/use_cases.dart';
import 'package:solar_energy_prediction/features/map/domain/repositories/location_repository.dart';
import 'package:solar_energy_prediction/features/map/domain/use_cases/is_gps_service_enabled_use_case.dart';
import 'package:solar_energy_prediction/features/map/domain/use_cases/request_gps_service_use_case.dart';
import 'package:solar_energy_prediction/features/map/infrastructure/repositories/location_repository_impl.dart';

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
      ),
    ),
  );
}

Future<void> _initDependencies() async {
  serviceLocator
    ..registerLazySingleton<Location>(
      () => Location(),
    )
    ..registerLazySingleton<LocationRepository>(
      () => LocationRepositoryImpl(
        location: serviceLocator<Location>(),
      ),
    )
    ..registerLazySingleton<FutureUseCase<bool, void>>(
      () => IsGpsServiceEnabledUseCase(
        serviceLocator<LocationRepository>(),
      ),
      instanceName: '$IsGpsServiceEnabledUseCase',
    )
    ..registerLazySingleton<FutureUseCase<bool, void>>(
      () => RequestGpsServiceUseCase(
        serviceLocator<LocationRepository>(),
      ),
      instanceName: '$RequestGpsServiceUseCase',
    );
}
