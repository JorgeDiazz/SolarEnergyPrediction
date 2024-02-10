import 'package:solar_energy_prediction/features/map/domain/entities/solar_irradiance.dart';

class SkySolarIrradiance {
  final SolarIrradiance clearSky;
  final SolarIrradiance cloudySky;

  SkySolarIrradiance({
    required this.clearSky,
    required this.cloudySky,
  });
}
