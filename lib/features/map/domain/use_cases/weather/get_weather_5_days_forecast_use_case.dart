import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:solar_energy_prediction/core/use_cases/use_cases.dart';
import 'package:solar_energy_prediction/core/utils/typedefs.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/weather_forecast.dart';
import 'package:solar_energy_prediction/features/map/domain/repositories/map/weather_repository.dart';

class GetWeather5DaysForecastUseCase
    extends FutureUseCase<WeatherForecast, LatLng> {
  final WeatherRepository _repository;

  const GetWeather5DaysForecastUseCase(this._repository);

  @override
  ResultFuture<WeatherForecast> call(LatLng input) async {
    return _repository.getWeather5DaysForecast(location: input);
  }
}
