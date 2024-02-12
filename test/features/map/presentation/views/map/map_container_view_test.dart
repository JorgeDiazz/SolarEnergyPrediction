import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:location/location.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:solar_energy_prediction/core/config/l10n/l10n.dart';
import 'package:solar_energy_prediction/features/map/presentation/view_models/map/map_view_model.dart';
import 'package:solar_energy_prediction/features/map/presentation/views/map/fetching_current_location_view.dart';
import 'package:solar_energy_prediction/features/map/presentation/views/map/map_container_view.dart';
import 'package:solar_energy_prediction/features/map/presentation/views/map/map_view.dart';

import '../../utils/ui_utils.dart';
import '../../view_models/mocks/view_models_mock_helper.mocks.dart';

late S s;

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

  testWidgets('''GIVEN MapContainerView in its initial state
WHEN lastKnownLocation is default point
THEN FetchingCurrentLocationView is displayed''', (tester) async {
    // GIVEN, WHEN
    await _pumpMapContainerView(tester, viewModel);

    // THEN
    expect(find.byType(FetchingCurrentLocationView), findsOneWidget);
  });

  testWidgets('''GIVEN MapContainerView in its initial state
WHEN lastKnownLocation is NOT default point
THEN FetchingCurrentLocationView is displayed''', (tester) async {
    // GIVEN
    final locationData =
        LocationData.fromMap({'latitude': 4.123, 'longitude': 72.456});
    when(location.getLocation()).thenAnswer((_) async => locationData);

    viewModel.updateLastKnownLocation();

    // WHEN
    await _pumpMapContainerView(tester, viewModel);

    // THEN
    expect(find.byType(MapView), findsOneWidget);
  });
}

Future<void> _pumpMapContainerView(
    WidgetTester tester, MapViewModel viewModel) async {
  await tester.pumpWidget(
    buildLocalizedAppWidget(
      ChangeNotifierProvider(
        create: (_) => viewModel,
        child: Builder(
          builder: (context) {
            s = S.of(context);
            return const MapContainerView();
          },
        ),
      ),
    ),
  );
}
