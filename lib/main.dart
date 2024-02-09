import 'package:flutter/material.dart';
import 'package:solar_energy_prediction/core/config/l10n/l10n.dart';
import 'package:solar_energy_prediction/core/router/app_router.dart';
import 'package:solar_energy_prediction/core/service_locator/service_locator.dart';
import 'package:solar_energy_prediction/core/theme/app_theme.dart';

Future<void> main() async {
  await initServiceLocator();

  runApp(const SolarEnergyPredictionApp());
}

class SolarEnergyPredictionApp extends StatelessWidget {
  const SolarEnergyPredictionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      theme: AppTheme().getTheme(),
      localizationsDelegates: const [
        S.delegate,
      ],
    );
  }
}
