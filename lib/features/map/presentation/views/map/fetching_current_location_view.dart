import 'package:flutter/material.dart';
import 'package:solar_energy_prediction/core/config/l10n/l10n.dart';

/// Contains a progress indicator to indicate the app is getting user's current location
class FetchingCurrentLocationView extends StatelessWidget {
  const FetchingCurrentLocationView({super.key});

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
