import 'package:solar_energy_prediction/core/use_cases/use_cases.dart';
import 'package:solar_energy_prediction/core/utils/typedefs.dart';
import 'package:solar_energy_prediction/features/map/domain/repositories/gps_services/gps_services_repository.dart';

class IsGpsServiceEnabledUseCase extends FutureUseCase<bool, void> {
  final GpsServicesRepository _repository;

  const IsGpsServiceEnabledUseCase(this._repository);

  @override
  ResultFuture<bool> call(void input) async {
    return _repository.isGpsServiceEnabled();
  }
}
