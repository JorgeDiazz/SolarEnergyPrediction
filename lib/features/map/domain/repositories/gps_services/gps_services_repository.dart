import 'package:solar_energy_prediction/core/utils/typedefs.dart';

abstract class GpsServicesRepository {
  ResultFuture<bool> isGpsServiceEnabled();

  ResultFuture<bool> requestGpsService();
}
