import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:solar_energy_prediction/core/constants/network_constants.dart';
import 'package:solar_energy_prediction/core/errors/exceptions.dart';
import 'package:solar_energy_prediction/features/map/infrastructure/datasources/weather_datasource.dart';
import 'package:solar_energy_prediction/features/map/infrastructure/models/responses/weather_data_response.dart';

class WeatherDatasourceImpl implements WeatherDatasource {
  final Dio _dio;

  WeatherDatasourceImpl({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<WeatherDataResponse> fetchWeatherData(LatLng location) async {
    try {
      final response = await _dio.get(
        NetworkConstants.currentWeatherDataEndpoint,
        queryParameters: {
          'lat': location.latitude,
          'lon': location.longitude,
        },
      );

      return WeatherDataResponse.fromJson(response.data);
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);

      throw ServerException(
        message: e.toString(),
        statusCode: HttpStatus.httpVersionNotSupported,
      );
    }
  }
}