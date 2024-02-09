import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:solar_energy_prediction/core/config/l10n/l10n.dart';
import 'package:solar_energy_prediction/core/extensions/location_extensions.dart';
import 'package:solar_energy_prediction/core/notifier_helpers/snackbar_status_notifier.dart';
import 'package:solar_energy_prediction/core/theme/map_theme.dart';

class MapViewModel extends ChangeNotifier with SnackbarStatusMixin {
  final Location _location;

  Location get location => _location;

  LatLng _lastKnownLocation;

  LatLng get lastKnownLocation => _lastKnownLocation;

  GoogleMapController? _mapController;

  GoogleMapController? get mapController => _mapController;

  MapViewModel({
    required Location location,
  })  : _location = location,
        _lastKnownLocation = const LatLng(0, 0);

  Future<void> updateLastKnownLocation() async {
    final currentLocation = await location.getLocation();
    _lastKnownLocation = LatLng(currentLocation.latitude ?? 0, currentLocation.longitude ?? 0);
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
      final cameraUpdate = CameraUpdate.newLatLng(_lastKnownLocation);
      _mapController?.animateCamera(cameraUpdate);
    }
  }
}
