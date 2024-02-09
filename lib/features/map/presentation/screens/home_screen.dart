import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:solar_energy_prediction/core/service_locator/service_locator.dart';
import 'package:solar_energy_prediction/core/use_cases/use_cases.dart';
import 'package:solar_energy_prediction/core/widgets/overlays/snackbar_overlay.dart';
import 'package:solar_energy_prediction/features/map/domain/use_cases/is_gps_service_enabled_use_case.dart';
import 'package:solar_energy_prediction/features/map/domain/use_cases/request_gps_service_use_case.dart';
import 'package:solar_energy_prediction/features/map/presentation/view_models/map_view_model.dart';
import 'package:solar_energy_prediction/features/map/presentation/view_models/request_gps_services_view_model.dart';
import 'package:solar_energy_prediction/features/map/presentation/views/map_view.dart';
import 'package:solar_energy_prediction/features/map/presentation/views/request_gps_services_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => _createRequestGpsServicesViewModel()..checkGpsStatus(),
            ),
            ChangeNotifierProvider(
              create: (_) => _createMapViewModel()..updateLastKnownLocation(),
            ),
          ],
          child: Consumer<RequestGpsServicesViewModel>(
            builder: (_, requestGpsServicesViewModel, __) {
              return SnackbarOverlay(
                snackBarStatus: requestGpsServicesViewModel.snackBarStatus,
                child: requestGpsServicesViewModel.gpsServiceEnabledAndGranted
                    ? const MapView()
                    : const RequestGpsServicesView(),
              );
            },
          ),
        ),
      ),
    );
  }

  RequestGpsServicesViewModel _createRequestGpsServicesViewModel() => RequestGpsServicesViewModel(
        location: serviceLocator<Location>(),
        isGpsServiceEnabledUseCase: serviceLocator<FutureUseCase<bool, void>>(
          instanceName: '$IsGpsServiceEnabledUseCase',
        ),
        requestGpsServiceUseCase: serviceLocator<FutureUseCase<bool, void>>(
          instanceName: '$RequestGpsServiceUseCase',
        ),
      );

  MapViewModel _createMapViewModel() => MapViewModel(
        location: serviceLocator<Location>(),
      );
}
