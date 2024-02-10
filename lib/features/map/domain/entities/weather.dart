import 'package:solar_energy_prediction/features/map/domain/entities/temperature.dart';

class Weather {
  final int timestamp;
  final Temperature temperature;
  final String description;
  final String iconUrl;

  Weather({
    required this.timestamp,
    required this.temperature,
    required this.description,
    required this.iconUrl,
  });
}
