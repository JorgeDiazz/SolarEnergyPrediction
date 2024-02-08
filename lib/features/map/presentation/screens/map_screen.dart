import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar_energy_prediction/core/widgets/overlays/snackbar_overlay.dart';
import 'package:solar_energy_prediction/features/map/presentation/view_models/map_view_model.dart';
import 'package:solar_energy_prediction/features/map/presentation/views/map_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = MapViewModel();

    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => viewModel,
        child: SafeArea(
          child: SnackbarOverlay(
            snackBarStatus: viewModel.snackBarStatus,
            child: const MapView(),
          ),
        ),
      ),
    );
  }
}
