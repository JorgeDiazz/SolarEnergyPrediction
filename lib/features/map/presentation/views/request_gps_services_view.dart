import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar_energy_prediction/core/config/l10n/l10n.dart';
import 'package:solar_energy_prediction/features/map/presentation/view_models/request_gps_services_view_model.dart';

class RequestGpsServicesView extends StatelessWidget {
  const RequestGpsServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
    return MaterialButton(
      color: Colors.black,
      shape: const StadiumBorder(),
      elevation: 0,
      splashColor: Colors.transparent,
      onPressed: () async => onRequestGpsServicesButtonPressed(context),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Future<void> onRequestGpsServicesButtonPressed(BuildContext context) async {
    final viewModel = context.read<RequestGpsServicesViewModel>();
    await viewModel.checkGpsStatus();
  }
}
