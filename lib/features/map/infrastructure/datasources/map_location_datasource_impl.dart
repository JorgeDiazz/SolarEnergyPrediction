import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:solar_energy_prediction/core/constants/network_constants.dart';
import 'package:solar_energy_prediction/core/errors/exceptions.dart';
import 'package:solar_energy_prediction/core/extensions/datetime_extensions.dart';
import 'package:solar_energy_prediction/features/map/infrastructure/datasources/map_location_datasource.dart';
import 'package:solar_energy_prediction/features/map/infrastructure/models/responses/solar_irradiance_response.dart';

class MapLocationDatasourceImpl implements MapLocationDatasource {
  final Dio _dio;

  MapLocationDatasourceImpl({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<SolarIrradianceResponse> fetchSolarIrradiance(
      LatLng location, DateTime date) async {
    try {
      final response = await _dio.get(
        NetworkConstants.solarEnergyPredictionEndpoint,
        queryParameters: {
          'lat': location.latitude,
          'lon': location.longitude,
          'date': date.toYearMonthDay(),
        },
      );

      return SolarIrradianceResponse.fromJson(response.data);
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
