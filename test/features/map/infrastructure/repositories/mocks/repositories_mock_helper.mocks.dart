// Mocks generated by Mockito 5.4.3 from annotations
// in solar_energy_prediction/test/features/map/infrastructure/repositories/mocks/repositories_mock_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:google_maps_flutter/google_maps_flutter.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:solar_energy_prediction/features/map/infrastructure/datasources/weather_datasource.dart'
    as _i4;
import 'package:solar_energy_prediction/features/map/infrastructure/models/responses/weather_5_days_forecast_response.dart'
    as _i3;
import 'package:solar_energy_prediction/features/map/infrastructure/models/responses/weather_data_response.dart'
    as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeWeatherDataResponse_0 extends _i1.SmartFake
    implements _i2.WeatherDataResponse {
  _FakeWeatherDataResponse_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWeather5DaysForecastResponse_1 extends _i1.SmartFake
    implements _i3.Weather5DaysForecastResponse {
  _FakeWeather5DaysForecastResponse_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [WeatherDatasource].
///
/// See the documentation for Mockito's code generation for more information.
class MockWeatherDatasource extends _i1.Mock implements _i4.WeatherDatasource {
  MockWeatherDatasource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.WeatherDataResponse> fetchWeatherData(_i6.LatLng? location) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchWeatherData,
          [location],
        ),
        returnValue: _i5.Future<_i2.WeatherDataResponse>.value(
            _FakeWeatherDataResponse_0(
          this,
          Invocation.method(
            #fetchWeatherData,
            [location],
          ),
        )),
      ) as _i5.Future<_i2.WeatherDataResponse>);

  @override
  _i5.Future<_i3.Weather5DaysForecastResponse> fetchWeather5DaysForecast(
          _i6.LatLng? location) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchWeather5DaysForecast,
          [location],
        ),
        returnValue: _i5.Future<_i3.Weather5DaysForecastResponse>.value(
            _FakeWeather5DaysForecastResponse_1(
          this,
          Invocation.method(
            #fetchWeather5DaysForecast,
            [location],
          ),
        )),
      ) as _i5.Future<_i3.Weather5DaysForecastResponse>);
}
