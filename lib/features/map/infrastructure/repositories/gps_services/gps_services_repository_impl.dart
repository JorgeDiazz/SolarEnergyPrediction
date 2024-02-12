import 'package:dartz/dartz.dart';
import 'package:location/location.dart';
import 'package:solar_energy_prediction/core/errors/failures.dart';
import 'package:solar_energy_prediction/core/utils/typedefs.dart';
import 'package:solar_energy_prediction/features/map/domain/repositories/gps_services/gps_services_repository.dart';

/// Represents the implementation of GpsServicesRepository
/// Right wrapper means expected response
// Left wrapper means an exception occurred
class GpsServicesRepositoryImpl implements GpsServicesRepository {
  final Location location;

  GpsServicesRepositoryImpl({required this.location});

  @override
  ResultFuture<bool> isGpsServiceEnabled() async {
    try {
      final gpsServiceEnabled = await location.serviceEnabled();
      return Right(gpsServiceEnabled);
    } catch (e) {
      return Left(ServicesFailure(
          message:
              'Error when checking if GPS service is enabled. Exception: $e'));
    }
  }

  @override
  ResultFuture<bool> requestGpsService() async {
    try {
      final gpsServiceEnabled = await location.requestService();
      return Right(gpsServiceEnabled);
    } catch (e) {
      return Left(ServicesFailure(
          message: 'Error when requesting GPS service. Exception: $e'));
    }
  }
}
