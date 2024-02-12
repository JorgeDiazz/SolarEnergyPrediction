import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:solar_energy_prediction/features/map/infrastructure/mappers/weather_mapper.dart';
import 'package:solar_energy_prediction/features/map/infrastructure/models/responses/weather_5_days_forecast_response.dart';
import 'package:solar_energy_prediction/features/map/infrastructure/models/responses/weather_data_response.dart';

void main() {
  test('''GIVEN an instance of WeatherDataResponse
  WHEN #toEntity is called
  THEN a WeatherData instance is returned''', () {
    // GIVEN
    const location = LatLng(44.34, 10.99);

    final weatherDataResponse = WeatherDataResponse(
      coord: CoordResponse(
        lat: location.latitude,
        lon: location.longitude,
      ),
    );

    // WHEN
    final weatherData = weatherDataResponse.toEntity();

    // THEN
    expect(weatherData.mapLocation.coordinates.latitude,
        weatherDataResponse.coord?.lat);
    expect(weatherData.mapLocation.coordinates.longitude,
        weatherDataResponse.coord?.lon);
  });

  test('''GIVEN an instance of Weather5DaysForecastResponse
  WHEN #toEntity is called
  THEN a WeatherForecast instance is returned''', () {
    // GIVEN
    const location = LatLng(44.34, 10.99);

    final weather5DaysForecastResponse = Weather5DaysForecastResponse(
      city: City(
        coord: Coord(
          lat: location.latitude,
          lon: location.longitude,
        ),
      ),
    );

    // WHEN
    final weatherForecast = weather5DaysForecastResponse.toEntity();

    // THEN
    expect(weatherForecast.mapLocation.coordinates.latitude,
        weather5DaysForecastResponse.city?.coord?.lat);
    expect(weatherForecast.mapLocation.coordinates.longitude,
        weather5DaysForecastResponse.city?.coord?.lon);
  });

  test('''GIVEN an instance of List<ForecastResponse>
  WHEN #toEntity is called
  THEN a List<Weather> instance is returned''', () {
    // GIVEN
    final forecastResponse = ForecastResponse(
      main: MainClass(temp: 25),
    );

    final forecastResponseList = [forecastResponse];

    // WHEN
    final weatherList = forecastResponseList.toEntity();

    // THEN
    expect(weatherList.first.temperature.average, forecastResponse.main?.temp);
  });
}
