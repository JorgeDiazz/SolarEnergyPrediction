import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solar_energy_prediction/core/config/l10n/l10n.dart';
import 'package:solar_energy_prediction/features/map/presentation/views/map/fetching_current_location_view.dart';

import '../../utils/ui_utils.dart';

late S s;

void main() {
  setUpAll(() async {
    await S.load(const Locale('en', 'US'));
  });

  testWidgets('''GIVEN FetchingCurrentLocationViewTest in its initial state
WHEN the view is pumped  
THEN all expected widgets are displayed''', (tester) async {
    // GIVEN, WHEN
    await _pumpFetchingCurrentLocationView(tester);

    // THEN
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text(s.locating_user_on_map_text), findsOneWidget);
  });
}

Future<void> _pumpFetchingCurrentLocationView(WidgetTester tester) async {
  await tester.pumpWidget(
    buildLocalizedAppWidget(
      Builder(
        builder: (context) {
          s = S.of(context);
          return const FetchingCurrentLocationView();
        },
      ),
    ),
  );
}
