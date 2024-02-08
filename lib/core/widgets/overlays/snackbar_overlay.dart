import 'dart:async';

import 'package:flutter/material.dart';
import 'package:solar_energy_prediction/core/notifier_helpers/snackbar_status_model.dart';
import 'package:solar_energy_prediction/core/theme/app_colors.dart';

class SnackbarOverlay extends StatelessWidget {
  final SnackbarStatusModel snackBarStatus;
  final Widget child;

  const SnackbarOverlay({
    super.key,
    required this.snackBarStatus,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<SnackbarMessage?>(
      valueListenable: snackBarStatus,
      builder: _buildContent,
      child: child,
    );
  }

  Widget _buildContent(
    BuildContext context,
    SnackbarMessage? snackBarMessage,
    Widget? child,
  ) {
    if (snackBarMessage != null) {
      snackBarStatus.reset();
      _showSnackBar(context, snackBarMessage);
    }

    return child!;
  }

  void _showSnackBar(BuildContext context, SnackbarMessage message) {
    Timer.run(() {
      final snackBar = SnackBar(
        content: Text(
          message.message,
        ),
        backgroundColor:
            message.type == SnackbarMessageType.error ? AppColors.pinkSalmon : AppColors.grayEmperor,
      );

      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(snackBar);
    });
  }
}
