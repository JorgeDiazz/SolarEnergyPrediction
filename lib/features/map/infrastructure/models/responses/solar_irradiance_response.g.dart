// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solar_irradiance_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SolarIrradianceResponse _$SolarIrradianceResponseFromJson(
        Map<String, dynamic> json) =>
    SolarIrradianceResponse(
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      tz: json['tz'] as String,
      sunrise: DateTime.parse(json['sunrise'] as String),
      sunset: DateTime.parse(json['sunset'] as String),
      irradiance:
          Irradiance.fromJson(json['irradiance'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SolarIrradianceResponseToJson(
        SolarIrradianceResponse instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lon,
      'date': instance.date.toIso8601String(),
      'tz': instance.tz,
      'sunrise': instance.sunrise.toIso8601String(),
      'sunset': instance.sunset.toIso8601String(),
      'irradiance': instance.irradiance,
    };

Irradiance _$IrradianceFromJson(Map<String, dynamic> json) => Irradiance(
      daily: (json['daily'] as List<dynamic>)
          .map((e) => Daily.fromJson(e as Map<String, dynamic>))
          .toList(),
      hourly: (json['hourly'] as List<dynamic>)
          .map((e) => Hourly.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$IrradianceToJson(Irradiance instance) =>
    <String, dynamic>{
      'daily': instance.daily,
      'hourly': instance.hourly,
    };

Daily _$DailyFromJson(Map<String, dynamic> json) => Daily(
      clearSky: Sky.fromJson(json['clearSky'] as Map<String, dynamic>),
      cloudySky: Sky.fromJson(json['cloudySky'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DailyToJson(Daily instance) => <String, dynamic>{
      'clearSky': instance.clearSky,
      'cloudySky': instance.cloudySky,
    };

Sky _$SkyFromJson(Map<String, dynamic> json) => Sky(
      ghi: (json['ghi'] as num).toDouble(),
      dni: (json['dni'] as num).toDouble(),
      dhi: (json['dhi'] as num).toDouble(),
    );

Map<String, dynamic> _$SkyToJson(Sky instance) => <String, dynamic>{
      'ghi': instance.ghi,
      'dni': instance.dni,
      'dhi': instance.dhi,
    };

Hourly _$HourlyFromJson(Map<String, dynamic> json) => Hourly(
      hour: json['hour'] as int,
      clearSky: Sky.fromJson(json['clearSky'] as Map<String, dynamic>),
      cloudySky: Sky.fromJson(json['cloudySky'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HourlyToJson(Hourly instance) => <String, dynamic>{
      'hour': instance.hour,
      'clearSky': instance.clearSky,
      'cloudySky': instance.cloudySky,
    };
