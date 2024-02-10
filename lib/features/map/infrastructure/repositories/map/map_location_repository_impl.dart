import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:solar_energy_prediction/core/errors/exceptions.dart';
import 'package:solar_energy_prediction/core/errors/failures.dart';
import 'package:solar_energy_prediction/core/utils/typedefs.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/map_location.dart';
import 'package:solar_energy_prediction/features/map/domain/repositories/map/map_location_repository.dart';
import 'package:solar_energy_prediction/features/map/infrastructure/datasources/map_location_datasource.dart';
import 'package:solar_energy_prediction/features/map/infrastructure/mappers/solar_irradiance_mapper.dart';

class MapLocationRepositoryImpl implements MapLocationRepository {
  final MapLocationDatasource remoteDatasource;

  MapLocationRepositoryImpl({required this.remoteDatasource});

  @override
  ResultFuture<MapLocationData> getMapLocationData(
      {required LatLng location, required DateTime date}) async {
    try {
      final solarIrradianceResponse =
          await remoteDatasource.fetchSolarIrradiance(location, date);
      final mapLocationData = solarIrradianceResponse.toMapLocationData();

      return Right(mapLocationData);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
