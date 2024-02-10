import 'package:solar_energy_prediction/features/map/domain/entities/temperature.dart';

class Weather {
  final Temperature temperature;
  final String description;
  final String iconUrl;

  Weather({
    required this.temperature,
    required this.description,
    required this.iconUrl,
  });
}
