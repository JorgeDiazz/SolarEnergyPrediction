import 'package:flutter/material.dart';
import 'package:solar_energy_prediction/core/theme/app_colors.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: AppColors.purpleMedium,
        brightness: Brightness.light,
      );
}
