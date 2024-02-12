import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar_energy_prediction/core/config/l10n/l10n.dart';
import 'package:solar_energy_prediction/features/map/presentation/view_models/gps_services/request_gps_services_view_model.dart';

/// Displays a button to request GPS sensor enabled and location permission granted on-demand
class RequestGpsServicesView extends StatelessWidget {
  const RequestGpsServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Container(
      color: colors.background,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.of(context).app_name,
              style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              S.of(context).app_requires_location_services_and_permission_title,
              style: textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            _RequestGpsServicesButton(
              S.of(context).request_gps_services_button,
            )
          ],
        ),
      ),
    );
  }
}

class _RequestGpsServicesButton extends StatelessWidget {
  final String text;

  const _RequestGpsServicesButton(this.text);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return MaterialButton(
      color: colors.primary,
      shape: const StadiumBorder(),
      elevation: 0,
      splashColor: Colors.transparent,
      onPressed: () async => onRequestGpsServicesButtonPressed(context),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }

  Future<void> onRequestGpsServicesButtonPressed(BuildContext context) async {
    final viewModel = context.read<RequestGpsServicesViewModel>();
    await viewModel.checkGpsStatus();
  }
}
