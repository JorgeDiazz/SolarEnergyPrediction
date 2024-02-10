// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherDataResponse _$WeatherDataResponseFromJson(Map<String, dynamic> json) =>
    WeatherDataResponse(
      coord: json['coord'] == null
          ? null
          : CoordResponse.fromJson(json['coord'] as Map<String, dynamic>),
      weather: (json['weather'] as List<dynamic>?)
          ?.map((e) => WeatherResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      base: json['base'] as String?,
      main: json['main'] == null
          ? null
          : MainResponse.fromJson(json['main'] as Map<String, dynamic>),
      visibility: json['visibility'] as int?,
      wind: json['wind'] == null
          ? null
          : WindResponse.fromJson(json['wind'] as Map<String, dynamic>),
      rain: json['rain'] == null
          ? null
          : RainResponse.fromJson(json['rain'] as Map<String, dynamic>),
      clouds: json['clouds'] == null
          ? null
          : CloudsResponse.fromJson(json['clouds'] as Map<String, dynamic>),
      dt: json['dt'] as int?,
      sys: json['sys'] == null
          ? null
          : SysResponse.fromJson(json['sys'] as Map<String, dynamic>),
      timezone: json['timezone'] as int?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      cod: json['cod'] as int?,
    );

Map<String, dynamic> _$WeatherDataResponseToJson(
        WeatherDataResponse instance) =>
    <String, dynamic>{
      'coord': instance.coord,
      'weather': instance.weather,
      'base': instance.base,
      'main': instance.main,
      'visibility': instance.visibility,
      'wind': instance.wind,
      'rain': instance.rain,
      'clouds': instance.clouds,
      'dt': instance.dt,
      'sys': instance.sys,
      'timezone': instance.timezone,
      'id': instance.id,
      'name': instance.name,
      'cod': instance.cod,
    };

CloudsResponse _$CloudsResponseFromJson(Map<String, dynamic> json) =>
    CloudsResponse(
      all: json['all'] as int?,
    );

Map<String, dynamic> _$CloudsResponseToJson(CloudsResponse instance) =>
    <String, dynamic>{
      'all': instance.all,
    };

CoordResponse _$CoordResponseFromJson(Map<String, dynamic> json) =>
    CoordResponse(
      lon: (json['lon'] as num?)?.toDouble(),
      lat: (json['lat'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CoordResponseToJson(CoordResponse instance) =>
    <String, dynamic>{
      'lon': instance.lon,
      'lat': instance.lat,
    };

MainResponse _$MainResponseFromJson(Map<String, dynamic> json) => MainResponse(
      temp: (json['temp'] as num?)?.toDouble(),
      feelsLike: (json['feels_like'] as num?)?.toDouble(),
      tempMin: (json['temp_min'] as num?)?.toDouble(),
      tempMax: (json['temp_max'] as num?)?.toDouble(),
      pressure: (json['pressure'] as num?)?.toDouble(),
      humidity: (json['humidity'] as num?)?.toDouble(),
      seaLevel: (json['sea_level'] as num?)?.toDouble(),
      grndLevel: (json['grnd_level'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$MainResponseToJson(MainResponse instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'feels_like': instance.feelsLike,
      'temp_min': instance.tempMin,
      'temp_max': instance.tempMax,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'sea_level': instance.seaLevel,
      'grnd_level': instance.grndLevel,
    };

RainResponse _$RainResponseFromJson(Map<String, dynamic> json) => RainResponse(
      the1H: (json['1h'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$RainResponseToJson(RainResponse instance) =>
    <String, dynamic>{
      '1h': instance.the1H,
    };

SysResponse _$SysResponseFromJson(Map<String, dynamic> json) => SysResponse(
      type: json['type'] as int?,
      id: json['id'] as int?,
      country: json['country'] as String?,
      sunrise: json['sunrise'] as int?,
      sunset: json['sunset'] as int?,
    );

Map<String, dynamic> _$SysResponseToJson(SysResponse instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'country': instance.country,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
    };

WeatherResponse _$WeatherResponseFromJson(Map<String, dynamic> json) =>
    WeatherResponse(
      id: json['id'] as int?,
      main: json['main'] as String?,
      description: json['description'] as String?,
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$WeatherResponseToJson(WeatherResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'main': instance.main,
      'description': instance.description,
      'icon': instance.icon,
    };

WindResponse _$WindResponseFromJson(Map<String, dynamic> json) => WindResponse(
      speed: (json['speed'] as num?)?.toDouble(),
      deg: json['deg'] as int?,
      gust: (json['gust'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$WindResponseToJson(WindResponse instance) =>
    <String, dynamic>{
      'speed': instance.speed,
      'deg': instance.deg,
      'gust': instance.gust,
    };
