import 'package:json_annotation/json_annotation.dart';

part 'solar_irradiance_response.g.dart';

@JsonSerializable()
class SolarIrradianceResponse {
  double lat;
  double lon;
  DateTime date;
  String tz;
  DateTime sunrise;
  DateTime sunset;
  Irradiance irradiance;

  SolarIrradianceResponse({
    required this.lat,
    required this.lon,
    required this.date,
    required this.tz,
    required this.sunrise,
    required this.sunset,
    required this.irradiance,
  });

  factory SolarIrradianceResponse.fromJson(Map<String, dynamic> json) =>
      _$SolarIrradianceResponseFromJson(json);
}

@JsonSerializable()
class Irradiance {
  List<Daily> daily;
  List<Hourly> hourly;

  Irradiance({
    required this.daily,
    required this.hourly,
  });

  factory Irradiance.fromJson(Map<String, dynamic> json) =>
      _$IrradianceFromJson(json);
}

@JsonSerializable()
class Daily {
  Sky clearSky;
  Sky cloudySky;

  Daily({
    required this.clearSky,
    required this.cloudySky,
  });

  factory Daily.fromJson(Map<String, dynamic> json) => _$DailyFromJson(json);
}

@JsonSerializable()
class Sky {
  double ghi;
  double dni;
  double dhi;

  Sky({
    required this.ghi,
    required this.dni,
    required this.dhi,
  });

  factory Sky.fromJson(Map<String, dynamic> json) => _$SkyFromJson(json);
}

@JsonSerializable()
class Hourly {
  int hour;
  Sky clearSky;
  Sky cloudySky;

  Hourly({
    required this.hour,
    required this.clearSky,
    required this.cloudySky,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) => _$HourlyFromJson(json);
}
