import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:solar_energy_prediction/core/extensions/either_extensions.dart';
import 'package:solar_energy_prediction/core/notifier_helpers/snackbar_status_notifier.dart';
import 'package:solar_energy_prediction/core/use_cases/use_cases.dart';
import 'package:solar_energy_prediction/core/utils/permissions_manager.dart';

class MapViewModel extends ChangeNotifier with SnackbarStatusMixin {
  final Location _location;
  Location get location => _location;

  bool _gpsServiceEnabledAndGranted;
  bool get gpsServiceEnabledAndGranted => _gpsServiceEnabledAndGranted;

  final FutureUseCase<bool, void> _isGpsServiceEnabledUseCase;
  final FutureUseCase<bool, void> _requestGpsServiceUseCase;

  MapViewModel({
    required Location location,
    required FutureUseCase<bool, void> isGpsServiceEnabledUseCase,
    required FutureUseCase<bool, void> requestGpsServiceUseCase,
  })  : _location = location,
        _gpsServiceEnabledAndGranted = false,
        _isGpsServiceEnabledUseCase = isGpsServiceEnabledUseCase,
        _requestGpsServiceUseCase = requestGpsServiceUseCase;

  Future<void> init() async {
    await _checkGpsStatus();
  }

  Future<void> _checkGpsStatus() async {
    final isGpsServiceEnabledResult = await _isGpsServiceEnabledUseCase(null);

    isGpsServiceEnabledResult.fold((failure) {
      snackBarStatus.postError(failure.toString());
    }, (gpsServiceEnabled) async {
      await _requestGpsService(gpsServiceEnabled);
    });
  }

  Future<void> _requestGpsService(bool gpsServiceEnabled) async {
    if (!gpsServiceEnabled) {
      final requestGpsServiceResult = await _requestGpsServiceUseCase(null);

      if (requestGpsServiceResult.isLeft()) {
        final failure = requestGpsServiceResult.asLeft();
        snackBarStatus.postError(failure.toString());
      }
    }

    final locationPermissionGranted = await PermissionsManager.requestLocationPermission(_location);
    _gpsServiceEnabledAndGranted = gpsServiceEnabled && locationPermissionGranted;

    notifyListeners();
  }
}
