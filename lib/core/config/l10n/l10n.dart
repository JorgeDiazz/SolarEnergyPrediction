// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Solar Energy Prediction`
  String get app_name {
    return Intl.message(
      'Solar Energy Prediction',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `This app requires GPS enabled and location permission granted`
  String get app_requires_location_services_and_permission_title {
    return Intl.message(
      'This app requires GPS enabled and location permission granted',
      name: 'app_requires_location_services_and_permission_title',
      desc: '',
      args: [],
    );
  }

  /// `Request GPS services`
  String get request_gps_services_button {
    return Intl.message(
      'Request GPS services',
      name: 'request_gps_services_button',
      desc: '',
      args: [],
    );
  }

  /// `Locating user on map...`
  String get locating_user_on_map_text {
    return Intl.message(
      'Locating user on map...',
      name: 'locating_user_on_map_text',
      desc: '',
      args: [],
    );
  }

  /// `User location is unknown!`
  String get user_location_is_unknown_text {
    return Intl.message(
      'User location is unknown!',
      name: 'user_location_is_unknown_text',
      desc: '',
      args: [],
    );
  }

  /// `Location selected`
  String get location_selected_title {
    return Intl.message(
      'Location selected',
      name: 'location_selected_title',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
