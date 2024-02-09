import 'package:solar_energy_prediction/core/use_cases/use_cases.dart';
import 'package:solar_energy_prediction/core/utils/typedefs.dart';
import 'package:solar_energy_prediction/features/map/domain/repositories/location_repository.dart';

class RequestGpsServiceUseCase extends FutureUseCase<bool, void> {
  final LocationRepository _repository;

  const RequestGpsServiceUseCase(this._repository);

  @override
  ResultFuture<bool> call(void input) async {
    return _repository.requestGpsService();
  }
}