import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar_energy_prediction/features/map/presentation/view_models/map_view_model.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MapViewModel>();

    return Center(
      child: Text(
        viewModel.gpsServiceEnabledAndGranted ? 'Enabled' : 'Disabled',
      ),
    );
  }
}
