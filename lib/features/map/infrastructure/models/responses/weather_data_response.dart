import 'package:json_annotation/json_annotation.dart';

part 'weather_data_response.g.dart';

/// Represents the response for current WeatherData endpoint
@JsonSerializable()
class WeatherDataResponse {
  @JsonKey(name: "coord")
  final CoordResponse? coord;
  @JsonKey(name: "weather")
  final List<WeatherResponse>? weather;
  @JsonKey(name: "base")
  final String? base;
  @JsonKey(name: "main")
  final MainResponse? main;
  @JsonKey(name: "visibility")
  final int? visibility;
  @JsonKey(name: "wind")
  final WindResponse? wind;
  @JsonKey(name: "rain")
  final RainResponse? rain;
  @JsonKey(name: "clouds")
  final CloudsResponse? clouds;
  @JsonKey(name: "dt")
  final int? dt;
  @JsonKey(name: "sys")
  final SysResponse? sys;
  @JsonKey(name: "timezone")
  final int? timezone;
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "cod")
  final int? cod;

  WeatherDataResponse({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.rain,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  factory WeatherDataResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherDataResponseFromJson(json);
}

@JsonSerializable()
class CloudsResponse {
  @JsonKey(name: "all")
  final int? all;

  CloudsResponse({
    this.all,
  });

  factory CloudsResponse.fromJson(Map<String, dynamic> json) =>
      _$CloudsResponseFromJson(json);
}

@JsonSerializable()
class CoordResponse {
  @JsonKey(name: "lon")
  final double? lon;
  @JsonKey(name: "lat")
  final double? lat;

  CoordResponse({
    this.lon,
    this.lat,
  });

  factory CoordResponse.fromJson(Map<String, dynamic> json) =>
      _$CoordResponseFromJson(json);
}

@JsonSerializable()
class MainResponse {
  @JsonKey(name: "temp")
  final double? temp;
  @JsonKey(name: "feels_like")
  final double? feelsLike;
  @JsonKey(name: "temp_min")
  final double? tempMin;
  @JsonKey(name: "temp_max")
  final double? tempMax;
  @JsonKey(name: "pressure")
  final double? pressure;
  @JsonKey(name: "humidity")
  final double? humidity;
  @JsonKey(name: "sea_level")
  final double? seaLevel;
  @JsonKey(name: "grnd_level")
  final double? grndLevel;

  MainResponse({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.grndLevel,
  });

  factory MainResponse.fromJson(Map<String, dynamic> json) =>
      _$MainResponseFromJson(json);
}

@JsonSerializable()
class RainResponse {
  @JsonKey(name: '1h')
  final double? the1H;

  RainResponse({
    this.the1H,
  });

  factory RainResponse.fromJson(Map<String, dynamic> json) =>
      _$RainResponseFromJson(json);
}

@JsonSerializable()
class SysResponse {
  @JsonKey(name: "type")
  final int? type;
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "country")
  final String? country;
  @JsonKey(name: "sunrise")
  final int? sunrise;
  @JsonKey(name: "sunset")
  final int? sunset;

  SysResponse({
    this.type,
    this.id,
    this.country,
    this.sunrise,
    this.sunset,
  });

  factory SysResponse.fromJson(Map<String, dynamic> json) =>
      _$SysResponseFromJson(json);
}

@JsonSerializable()
class WeatherResponse {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "main")
  final String? main;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "icon")
  final String? icon;

  WeatherResponse({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);
}

@JsonSerializable()
class WindResponse {
  @JsonKey(name: "speed")
  final double? speed;
  @JsonKey(name: "deg")
  final int? deg;
  @JsonKey(name: "gust")
  final double? gust;

  WindResponse({
    this.speed,
    this.deg,
    this.gust,
  });

  factory WindResponse.fromJson(Map<String, dynamic> json) =>
      _$WindResponseFromJson(json);
}
