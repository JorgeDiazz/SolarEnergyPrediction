import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:solar_energy_prediction/core/use_cases/use_cases.dart';
import 'package:solar_energy_prediction/core/utils/typedefs.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/weather_data.dart';
import 'package:solar_energy_prediction/features/map/domain/repositories/map/weather_repository.dart';

class GetWeatherDataUseCase extends FutureUseCase<WeatherData, LatLng> {
  final WeatherRepository _repository;

  const GetWeatherDataUseCase(this._repository);

  @override
  ResultFuture<WeatherData> call(LatLng input) async {
    return _repository.getWeatherData(location: input);
  }
}
