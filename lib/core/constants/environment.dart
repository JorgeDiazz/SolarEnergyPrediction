import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  // keys
  static String openWeatherMapKey = dotenv.env['OPEN_WEATHER_MAP_KEY'] ?? '';
}
