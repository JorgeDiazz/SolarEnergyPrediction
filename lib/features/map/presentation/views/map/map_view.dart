import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:solar_energy_prediction/core/extensions/location_extensions.dart';
import 'package:solar_energy_prediction/features/map/presentation/view_models/map/map_view_model.dart';
import 'package:solar_energy_prediction/features/map/presentation/widgets/current_location_button.dart';
import 'package:solar_energy_prediction/features/map/presentation/widgets/weather_data_bottom_sheet.dart';

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
        _GoogleMap(
          initialCameraPosition: initialCameraPosition,
          bottomSheetKey: bottomSheetKey,
          bottomSheetController: bottomSheetController,
        ),
        Positioned(
          bottom: 150,
          right: 20,
          child: CurrentLocationButton(
            onPressed: () {
              final viewModel = context.read<MapViewModel>();
              viewModel.locateUserOnMap();
            },
          ),
        ),
        WeatherDataBottomSheet(
          bottomSheetKey: bottomSheetKey,
          controller: bottomSheetController,
          mapLocationData: viewModel.mapLocationData,
          weatherForecast: viewModel.weatherForecast,
        ),
      ],
    );
  }
}

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
