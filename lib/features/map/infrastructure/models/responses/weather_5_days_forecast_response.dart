import 'package:json_annotation/json_annotation.dart';

part 'weather_5_days_forecast_response.g.dart';

@JsonSerializable()
class Weather5DaysForecastResponse {
  @JsonKey(name: "cod")
  String? cod;
  @JsonKey(name: "message")
  int? message;
  @JsonKey(name: "cnt")
  int? cnt;
  @JsonKey(name: "list")
  List<ForecastResponse>? list;
  @JsonKey(name: "city")
  City? city;

  Weather5DaysForecastResponse({
    this.cod,
    this.message,
    this.cnt,
    this.list,
    this.city,
  });

  factory Weather5DaysForecastResponse.fromJson(Map<String, dynamic> json) =>
      _$Weather5DaysForecastResponseFromJson(json);
}

@JsonSerializable()
class City {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "coord")
  Coord? coord;
  @JsonKey(name: "country")
  String? country;
  @JsonKey(name: "population")
  int? population;
  @JsonKey(name: "timezone")
  int? timezone;
  @JsonKey(name: "sunrise")
  int? sunrise;
  @JsonKey(name: "sunset")
  int? sunset;

  City({
    this.id,
    this.name,
    this.coord,
    this.country,
    this.population,
    this.timezone,
    this.sunrise,
    this.sunset,
  });

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
}

@JsonSerializable()
class Coord {
  @JsonKey(name: "lat")
  double? lat;
  @JsonKey(name: "lon")
  double? lon;

  Coord({
    this.lat,
    this.lon,
  });

  factory Coord.fromJson(Map<String, dynamic> json) => _$CoordFromJson(json);
}

@JsonSerializable()
class ForecastResponse {
  @JsonKey(name: "dt")
  int? dt;
  @JsonKey(name: "main")
  MainClass? main;
  @JsonKey(name: "weather")
  List<WeatherClass>? weather;
  @JsonKey(name: "clouds")
  Clouds? clouds;
  @JsonKey(name: "wind")
  Wind? wind;
  @JsonKey(name: "visibility")
  int? visibility;
  @JsonKey(name: "pop")
  double? pop;
  @JsonKey(name: "rain")
  Rain? rain;
  @JsonKey(name: "sys")
  Sys? sys;
  @JsonKey(name: "dt_txt")
  DateTime? dtTxt;

  ForecastResponse({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.visibility,
    this.pop,
    this.rain,
    this.sys,
    this.dtTxt,
  });

  factory ForecastResponse.fromJson(Map<String, dynamic> json) =>
      _$ForecastResponseFromJson(json);
}

@JsonSerializable()
class Clouds {
  @JsonKey(name: "all")
  int? all;

  Clouds({
    this.all,
  });

  factory Clouds.fromJson(Map<String, dynamic> json) => _$CloudsFromJson(json);
}

@JsonSerializable()
class MainClass {
  @JsonKey(name: "temp")
  double? temp;
  @JsonKey(name: "feels_like")
  double? feelsLike;
  @JsonKey(name: "temp_min")
  double? tempMin;
  @JsonKey(name: "temp_max")
  double? tempMax;
  @JsonKey(name: "pressure")
  int? pressure;
  @JsonKey(name: "sea_level")
  int? seaLevel;
  @JsonKey(name: "grnd_level")
  int? grndLevel;
  @JsonKey(name: "humidity")
  int? humidity;
  @JsonKey(name: "temp_kf")
  double? tempKf;

  MainClass({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.seaLevel,
    this.grndLevel,
    this.humidity,
    this.tempKf,
  });

  factory MainClass.fromJson(Map<String, dynamic> json) =>
      _$MainClassFromJson(json);
}

@JsonSerializable()
class Rain {
  @JsonKey(name: "3h")
  double? the3H;

  Rain({
    this.the3H,
  });

  factory Rain.fromJson(Map<String, dynamic> json) => _$RainFromJson(json);
}

@JsonSerializable()
class Sys {
  @JsonKey(name: "pod")
  String? pod;

  Sys({
    this.pod,
  });

  factory Sys.fromJson(Map<String, dynamic> json) => _$SysFromJson(json);
}

@JsonSerializable()
class WeatherClass {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "main")
  String? main;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "icon")
  String? icon;

  WeatherClass({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  factory WeatherClass.fromJson(Map<String, dynamic> json) =>
      _$WeatherClassFromJson(json);
}

@JsonSerializable()
class Wind {
  @JsonKey(name: "speed")
  double? speed;
  @JsonKey(name: "deg")
  int? deg;
  @JsonKey(name: "gust")
  double? gust;

  Wind({
    this.speed,
    this.deg,
    this.gust,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);
}
