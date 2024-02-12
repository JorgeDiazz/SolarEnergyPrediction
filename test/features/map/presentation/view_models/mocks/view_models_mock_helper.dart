import 'package:location/location.dart';
import 'package:mockito/annotations.dart';
import 'package:solar_energy_prediction/features/map/domain/use_cases/gps_services/is_gps_service_enabled_use_case.dart';
import 'package:solar_energy_prediction/features/map/domain/use_cases/gps_services/request_gps_service_use_case.dart';
import 'package:solar_energy_prediction/features/map/domain/use_cases/weather/get_weather_5_days_forecast_use_case.dart';
import 'package:solar_energy_prediction/features/map/domain/use_cases/weather/get_weather_data_use_case.dart';

@GenerateMocks([
  Location,
  GetWeatherDataUseCase,
  GetWeather5DaysForecastUseCase,
  IsGpsServiceEnabledUseCase,
  RequestGpsServiceUseCase,
])
class ViewModelsMockHelper {}
