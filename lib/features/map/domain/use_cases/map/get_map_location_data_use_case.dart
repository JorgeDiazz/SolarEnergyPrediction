import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:solar_energy_prediction/core/use_cases/use_cases.dart';
import 'package:solar_energy_prediction/core/utils/typedefs.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/map_location.dart';
import 'package:solar_energy_prediction/features/map/domain/repositories/map/map_location_repository.dart';

class GetMapLocationDataUseCase
    extends FutureUseCase<MapLocationData, Tuple2<LatLng, DateTime>> {
  final MapLocationRepository _repository;

  const GetMapLocationDataUseCase(this._repository);

  @override
  ResultFuture<MapLocationData> call(Tuple2<LatLng, DateTime> input) async {
    return _repository.getMapLocationData(
        location: input.value1, date: input.value2);
  }
}
