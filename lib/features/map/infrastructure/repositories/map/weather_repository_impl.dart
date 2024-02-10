import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:solar_energy_prediction/core/errors/exceptions.dart';
import 'package:solar_energy_prediction/core/errors/failures.dart';
import 'package:solar_energy_prediction/core/utils/typedefs.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/weather_data.dart';
import 'package:solar_energy_prediction/features/map/domain/repositories/map/weather_repository.dart';
import 'package:solar_energy_prediction/features/map/infrastructure/datasources/weather_datasource.dart';
import 'package:solar_energy_prediction/features/map/infrastructure/mappers/weather_mapper.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherDatasource remoteDatasource;

  WeatherRepositoryImpl({required this.remoteDatasource});

  @override
  ResultFuture<WeatherData> getWeatherData({required LatLng location}) async {
    try {
      final weatherDataResponse =
          await remoteDatasource.fetchWeatherData(location);
      final weatherData = weatherDataResponse.toEntity();

      return Right(weatherData);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
