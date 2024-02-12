import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar_energy_prediction/core/extensions/location_extensions.dart';
import 'package:solar_energy_prediction/core/utils/test_config.dart';
import 'package:solar_energy_prediction/features/map/presentation/view_models/map/map_view_model.dart';
import 'package:solar_energy_prediction/features/map/presentation/views/map/fetching_current_location_view.dart';
import 'package:solar_energy_prediction/features/map/presentation/views/map/map_view.dart';

/// Decides between FetchingCurrentLocationView and MapView depending on user's last known location
/// i.e. if lastKnownLocation is default point (0, 0), so it means that app is fetching current location and
/// FetchingCurrentLocationView must be displayed
/// Otherwise, if lastKnownLocation has another value, so MapView is rendered
class MapContainerView extends StatefulWidget {
  const MapContainerView({super.key});

  @override
  State<MapContainerView> createState() => _MapContainerViewState();
}

class _MapContainerViewState extends State<MapContainerView> {
  final bottomSheetKey = GlobalKey();
  final bottomSheetController = DraggableScrollableController();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MapViewModel>();

    return viewModel.lastKnownLocation.isDefaultPoint() &&
            !TestConfig.inTestMode
        ? const FetchingCurrentLocationView()
        : MapView(
            initialLocation: viewModel.lastKnownLocation,
            bottomSheetController: bottomSheetController,
            bottomSheetKey: bottomSheetKey,
          );
  }

  @override
  void dispose() {
    super.dispose();
    bottomSheetController.dispose();
  }
}
