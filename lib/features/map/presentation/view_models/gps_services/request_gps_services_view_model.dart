import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:solar_energy_prediction/core/extensions/either_extensions.dart';
import 'package:solar_energy_prediction/core/notifier_helpers/snackbar_status_notifier.dart';
import 'package:solar_energy_prediction/core/use_cases/use_cases.dart';
import 'package:solar_energy_prediction/core/utils/permissions_manager.dart';

/// Represents the view model for map view.
/// This class contains all the UI states for RequestGpsServicesView.
class RequestGpsServicesViewModel extends ChangeNotifier
    with SnackbarStatusMixin {
  final Location _location;
  Location get location => _location;

  bool _gpsServiceEnabledAndGranted;
  bool get gpsServiceEnabledAndGranted => _gpsServiceEnabledAndGranted;

  final FutureUseCase<bool, void> _isGpsServiceEnabledUseCase;
  final FutureUseCase<bool, void> _requestGpsServiceUseCase;

  RequestGpsServicesViewModel({
    required Location location,
    required FutureUseCase<bool, void> isGpsServiceEnabledUseCase,
    required FutureUseCase<bool, void> requestGpsServiceUseCase,
  })  : _location = location,
        _gpsServiceEnabledAndGranted = false,
        _isGpsServiceEnabledUseCase = isGpsServiceEnabledUseCase,
        _requestGpsServiceUseCase = requestGpsServiceUseCase;

  /// Checks if GPS sensor is whether enabled or not
  Future<void> checkGpsStatus() async {
    final isGpsServiceEnabledResult = await _isGpsServiceEnabledUseCase(null);

    isGpsServiceEnabledResult.fold((failure) {
      snackBarStatus.postError(failure.toString());
    }, (gpsServiceEnabled) async {
      await _requestGpsService(gpsServiceEnabled);
    });
  }

  /// Requests GPS sensor to the user
  Future<void> _requestGpsService(bool gpsServiceEnabled) async {
    if (!gpsServiceEnabled) {
      final requestGpsServiceResult = await _requestGpsServiceUseCase(null);

      if (requestGpsServiceResult.isLeft()) {
        final failure = requestGpsServiceResult.asLeft();
        snackBarStatus.postError(failure.toString());
      } else {
        gpsServiceEnabled = requestGpsServiceResult.asRight();
      }
    }

    /// Requests in-app location permission to the user
    final locationPermissionGranted =
        await PermissionsManager.requestLocationPermission(_location);
    _gpsServiceEnabledAndGranted =
        gpsServiceEnabled && locationPermissionGranted;

    notifyListeners();
  }
}
