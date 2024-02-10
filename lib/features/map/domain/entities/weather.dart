import 'package:solar_energy_prediction/features/map/domain/entities/temperature.dart';

class Weather {
  final Temperature temperature;
  final String description;

  Weather({
    required this.temperature,
    required this.description,
  });
}
