import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:solar_energy_prediction/core/extensions/location_extensions.dart';
import 'package:solar_energy_prediction/core/utils/test_config.dart';
import 'package:solar_energy_prediction/core/utils/ui_utils.dart';
import 'package:solar_energy_prediction/features/map/presentation/view_models/map/map_view_model.dart';
import 'package:solar_energy_prediction/features/map/presentation/widgets/current_location_button.dart';
import 'package:solar_energy_prediction/features/map/presentation/widgets/weather_data_bottom_sheet.dart';

/// Serves as the container for Google Maps widget.
/// It's the main view of the application, in which the user can explore new places, select them and
/// know their current weather and next 5-day forecast
class MapView extends StatelessWidget {
  static const defaultZoom = 15.0;

  final LatLng initialLocation;
  final DraggableScrollableController bottomSheetController;
  final GlobalKey<State<StatefulWidget>> bottomSheetKey;

  const MapView({
    super.key,
    required this.initialLocation,
    required this.bottomSheetController,
    required this.bottomSheetKey,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MapViewModel>();

    final CameraPosition initialCameraPosition = CameraPosition(
      target: initialLocation,
      zoom: defaultZoom,
    );

    return Stack(
      children: [
        if (!TestConfig.inTestMode)
          _GoogleMap(
            initialCameraPosition: initialCameraPosition,
            bottomSheetKey: bottomSheetKey,
            bottomSheetController: bottomSheetController,
          ),
        Positioned(
          bottom: UiUtils.isPortrait(context) ? 150 : 50,
          right: 20,
          child: CurrentLocationButton(
            onPressed: () {
              final viewModel = context.read<MapViewModel>();
              viewModel.locateUserOnMap();
            },
          ),
        ),
        if (!TestConfig.inTestMode)
          WeatherDataBottomSheet(
            bottomSheetKey: bottomSheetKey,
            controller: bottomSheetController,
            mapLocationData: viewModel.weatherData,
            weatherForecast: viewModel.weatherForecast,
          ),
      ],
    );
  }
}

/// Encapsulates the GoogleMap widget and its behavior
class _GoogleMap extends StatelessWidget {
  static const selectedLocationMarkerId = MarkerId('selectedLocation');
  static const defaultCenterOffset = 0.002;

  final CameraPosition initialCameraPosition;
  final GlobalKey<State<StatefulWidget>> bottomSheetKey;
  final DraggableScrollableController bottomSheetController;

  DraggableScrollableSheet get bottomSheet =>
      bottomSheetKey.currentWidget as DraggableScrollableSheet;

  const _GoogleMap({
    required this.initialCameraPosition,
    required this.bottomSheetKey,
    required this.bottomSheetController,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MapViewModel>();

    return GoogleMap(
      initialCameraPosition: initialCameraPosition,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      compassEnabled: false,
      mapToolbarEnabled: false,
      onMapCreated: (mapController) {
        final viewModel = context.read<MapViewModel>();
        viewModel.onMapInitialized(mapController);
      },
      markers: {
        Marker(
          markerId: selectedLocationMarkerId,
          position: viewModel.selectedLocation,
        )
      },
      onTap: (selectedLocation) => onLocationTap(viewModel, selectedLocation),
    );
  }

  void onLocationTap(MapViewModel viewModel, LatLng selectedLocation) {
    if (viewModel.selectedLocation.isDefaultPoint()) {
      _updateSelectedLocation(selectedLocation, viewModel);
    } else {
      _clearSelectedLocation(viewModel);
    }
  }

  void _updateSelectedLocation(
    LatLng selectedLocation,
    MapViewModel viewModel,
  ) {
    viewModel.updateSelectedLocation(selectedLocation);

    final newLocationOnMap = LatLng(
      selectedLocation.latitude - defaultCenterOffset,
      selectedLocation.longitude,
    );

    viewModel.locatePointOnMap(newLocationOnMap);
    viewModel.fetchMapLocationData(selectedLocation);

    _showBottomSheet();
  }

  void _clearSelectedLocation(MapViewModel viewModel) {
    viewModel.clearSelectedLocation();
    _hideBottomSheet();
  }

  void _showBottomSheet() {
    _animateBottomSheet(bottomSheet.snapSizes!.last);
  }

  void _hideBottomSheet() {
    _animateBottomSheet(bottomSheet.minChildSize);
  }

  void _animateBottomSheet(double size) {
    bottomSheetController.animateTo(
      size,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }
}
