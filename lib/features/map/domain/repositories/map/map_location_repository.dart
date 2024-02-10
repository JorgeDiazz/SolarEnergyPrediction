import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:solar_energy_prediction/core/utils/typedefs.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/map_location.dart';

abstract class MapLocationRepository {
  ResultFuture<MapLocationData> getMapLocationData(
      {required LatLng location, required DateTime date});
}
