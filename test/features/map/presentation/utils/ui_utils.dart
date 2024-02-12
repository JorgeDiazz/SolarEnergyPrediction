import 'package:flutter/material.dart';
import 'package:solar_energy_prediction/core/config/l10n/l10n.dart';

Widget buildLocalizedAppWidget(Widget widget, {Color? backgroundColor}) =>
    MaterialApp(
      home: Scaffold(
        body: widget,
        backgroundColor: backgroundColor,
      ),
      localizationsDelegates: const [S.delegate],
      supportedLocales: S.delegate.supportedLocales,
    );
