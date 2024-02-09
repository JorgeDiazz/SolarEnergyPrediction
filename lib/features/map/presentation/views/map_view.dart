import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:solar_energy_prediction/core/config/l10n/l10n.dart';
import 'package:solar_energy_prediction/core/extensions/location_extensions.dart';
import 'package:solar_energy_prediction/features/map/presentation/view_models/map_view_model.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MapViewModel>();

    return viewModel.lastKnownLocation.isDefaultPoint()
        ? const _LoadingView()
        : Stack(
            children: [
              _GoogleMapView(
                initialLocation: viewModel.lastKnownLocation,
              ),
              const Positioned(
                bottom: 30,
                right: 20,
                child: _CurrentLocationButton(),
              ),
            ],
          );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 15),
          Text(
            S.of(context).locating_user_on_map_text,
            style: textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

class _GoogleMapView extends StatelessWidget {
  final LatLng initialLocation;

  const _GoogleMapView({
    required this.initialLocation,
  });

  @override
  Widget build(BuildContext context) {
    final CameraPosition initialCameraPosition = CameraPosition(
      target: initialLocation,
      zoom: 15,
    );

    return GoogleMap(
      initialCameraPosition: initialCameraPosition,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: (mapController) {
        final viewModel = context.read<MapViewModel>();
        viewModel.onMapInitialized(mapController);
      },
    );
  }
}

class _CurrentLocationButton extends StatelessWidget {
  const _CurrentLocationButton();

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      maxRadius: 25,
      child: IconButton(
        icon: const Icon(
          Icons.my_location_outlined,
          color: Colors.black,
        ),
        onPressed: () {
          final viewModel = context.read<MapViewModel>();
          viewModel.locateUserOnMap();
        },
      ),
    );
  }
}
