import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:solar_energy_prediction/core/config/l10n/l10n.dart';
import 'package:solar_energy_prediction/features/map/presentation/view_models/map/map_view_model.dart';
import 'package:solar_energy_prediction/features/map/presentation/views/map/map_view.dart';
import 'package:solar_energy_prediction/features/map/presentation/widgets/current_location_button.dart';
import 'package:solar_energy_prediction/features/map/presentation/widgets/weather_data_bottom_sheet.dart';

import '../../utils/ui_utils.dart';
import '../../view_models/mocks/view_models_mock_helper.mocks.dart';

void main() {
  final location = MockLocation();
  final getWeatherDataUseCase = MockGetWeatherDataUseCase();
  final getWeather5DaysForecastUseCase = MockGetWeather5DaysForecastUseCase();

  late MapViewModel viewModel;

  setUp(() {
    viewModel = MapViewModel(
      location: location,
      getWeatherDataUseCase: getWeatherDataUseCase,
      getWeather5DaysForecastUseCase: getWeather5DaysForecastUseCase,
    );
  });

  setUpAll(() async {
    await S.load(const Locale('en', 'US'));
  });

  testWidgets('''GIVEN MapView in its initial state
WHEN the view is pumped  
THEN all expected widgets are displayed''', (tester) async {
    // GIVEN, WHEN
    await _pumpMapView(tester, viewModel);

    // THEN
    expect(find.byType(GoogleMap), findsOneWidget);
    expect(find.byType(CurrentLocationButton), findsOneWidget);
    expect(find.byType(WeatherDataBottomSheet), findsOneWidget);
  });

  testWidgets('''GIVEN CurrentLocationButton 
WHEN such button is tapped  
THEN lastKnownLocation gets updated''', (tester) async {
    // GIVEN
    await _pumpMapView(tester, viewModel);

    // WHEN
    await tester.tap(find.byType(CurrentLocationButton));

    // THEN
    expect(viewModel.lastKnownLocation, isNotNull);
  });
}

Future<void> _pumpMapView(WidgetTester tester, MapViewModel viewModel) async {
  await tester.pumpWidget(
    buildLocalizedAppWidget(
      ChangeNotifierProvider(
        create: (_) => viewModel,
        child: Builder(
          builder: (context) {
            return MapView(
              initialLocation: viewModel.lastKnownLocation,
              bottomSheetController: DraggableScrollableController(),
              bottomSheetKey: GlobalKey(),
            );
          },
        ),
      ),
    ),
  );
}
