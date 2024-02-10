import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:solar_energy_prediction/core/config/l10n/l10n.dart';
import 'package:solar_energy_prediction/core/extensions/location_extensions.dart';
import 'package:solar_energy_prediction/core/notifier_helpers/snackbar_status_notifier.dart';
import 'package:solar_energy_prediction/core/theme/map_theme.dart';
import 'package:solar_energy_prediction/core/use_cases/use_cases.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/weather_data.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/weather_forecast.dart';

class MapViewModel extends ChangeNotifier with SnackbarStatusMixin {
  final Location _location;

  Location get location => _location;

  LatLng _lastKnownLocation;

  LatLng get lastKnownLocation => _lastKnownLocation;

  LatLng _selectedLocation;

  LatLng get selectedLocation => _selectedLocation;

  GoogleMapController? _mapController;

  GoogleMapController? get mapController => _mapController;

  WeatherData? _mapLocationData;

  WeatherData? get mapLocationData => _mapLocationData;

  WeatherForecast? _weatherForecast;

  WeatherForecast? get weatherForecast => _weatherForecast;

  final FutureUseCase<WeatherData, LatLng> _getWeatherDataUseCase;
  final FutureUseCase<WeatherForecast, LatLng> _getWeather5DaysForecastUseCase;

  MapViewModel({
    required Location location,
    required FutureUseCase<WeatherData, LatLng> getWeatherDataUseCase,
    required FutureUseCase<WeatherForecast, LatLng>
        getWeather5DaysForecastUseCase,
  })  : _location = location,
        _getWeatherDataUseCase = getWeatherDataUseCase,
        _getWeather5DaysForecastUseCase = getWeather5DaysForecastUseCase,
        _lastKnownLocation = const LatLng(0, 0),
        _selectedLocation = const LatLng(0, 0);

  Future<void> updateLastKnownLocation() async {
    final currentLocation = await location.getLocation();
    _lastKnownLocation =
        LatLng(currentLocation.latitude ?? 0, currentLocation.longitude ?? 0);
    notifyListeners();
  }

  void onMapInitialized(GoogleMapController mapController) {
    _mapController = mapController;
    _mapController?.setMapStyle(jsonEncode(mapTheme));
  }

  void locateUserOnMap() {
    if (_lastKnownLocation.isDefaultPoint()) {
      snackBarStatus.postError(S.current.user_location_is_unknown_text);
    } else {
      locatePointOnMap(_lastKnownLocation);
    }
  }

  void locatePointOnMap(LatLng location) {
    final cameraUpdate = CameraUpdate.newLatLng(location);
    _mapController?.animateCamera(cameraUpdate);
  }

  void updateSelectedLocation(LatLng selectedLocation) {
    _selectedLocation = selectedLocation;
    notifyListeners();
  }

  void clearSelectedLocation() {
    _selectedLocation = const LatLng(0, 0);
    _mapLocationData = null;
    _weatherForecast = null;
    notifyListeners();
  }

  Future<void> updateMapLocationData(LatLng currentLocation) async {
    final weatherDataResult = await _getWeatherDataUseCase(currentLocation);

    weatherDataResult.fold((failure) {
      snackBarStatus.postError(failure.toString());
    }, (mapLocationData) {
      _mapLocationData = mapLocationData;
    });
  }

  Future<void> getWeather5DaysForecast(LatLng currentLocation) async {
    final weatherForecastResult =
        await _getWeather5DaysForecastUseCase(currentLocation);

    weatherForecastResult.fold((failure) {
      snackBarStatus.postError(failure.toString());
    }, (weatherForecast) {
      _weatherForecast = weatherForecast;
    });
  }

  Future<void> fetchMapLocationData(LatLng selectedLocation) async {
    await Future.wait([
      updateMapLocationData(selectedLocation),
      getWeather5DaysForecast(selectedLocation),
    ]);

    notifyListeners();
  }
}
