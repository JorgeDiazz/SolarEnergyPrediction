import 'package:flutter/material.dart';
import 'package:solar_energy_prediction/core/notifier_helpers/snackbar_status_model.dart';

mixin SnackbarStatusMixin on ChangeNotifier {
  final snackBarStatus = SnackbarStatusModel();
}
