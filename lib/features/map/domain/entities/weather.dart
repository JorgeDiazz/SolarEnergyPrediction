import 'package:solar_energy_prediction/features/map/domain/entities/temperature.dart';

/// Represents the weather for a selected location on the map
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
