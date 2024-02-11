// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en_US locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en_US';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "app_name": MessageLookupByLibrary.simpleMessage("Weather Data"),
        "app_requires_location_services_and_permission_title":
            MessageLookupByLibrary.simpleMessage(
                "This app requires GPS enabled and location permission granted"),
        "locating_user_on_map_text":
            MessageLookupByLibrary.simpleMessage("Locating user on map..."),
        "max_temperature_subtitle":
            MessageLookupByLibrary.simpleMessage("Max:"),
        "min_temperature_subtitle":
            MessageLookupByLibrary.simpleMessage("Min:"),
        "request_gps_services_button":
            MessageLookupByLibrary.simpleMessage("Request GPS services"),
        "user_location_is_unknown_text":
            MessageLookupByLibrary.simpleMessage("User location is unknown!"),
        "weather_5_days_forecast_title":
            MessageLookupByLibrary.simpleMessage("5-DAY FORECAST")
      };
}
