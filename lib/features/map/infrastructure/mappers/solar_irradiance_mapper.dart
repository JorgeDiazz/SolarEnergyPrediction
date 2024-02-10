import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/map_location.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/sky_solar_irradiance.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/solar_irradiance.dart';
import 'package:solar_energy_prediction/features/map/infrastructure/models/responses/solar_irradiance_response.dart';

extension SolarIrradianceToMapLocationData on SolarIrradianceResponse {
  MapLocationData toMapLocationData() => MapLocationData(
        country: 'country',
        city: 'city',
        latLng: LatLng(lat, lon),
        currentSolarIrradiance: SkySolarIrradiance(
          clearSky: SolarIrradiance(
            ghi: irradiance.daily.first.clearSky.ghi,
            dni: irradiance.daily.first.clearSky.dni,
            dhi: irradiance.daily.first.clearSky.dhi,
          ),
          cloudySky: SolarIrradiance(
            ghi: irradiance.daily.first.cloudySky.ghi,
            dni: irradiance.daily.first.cloudySky.dni,
            dhi: irradiance.daily.first.cloudySky.dhi,
          ),
        ),
      );
}
