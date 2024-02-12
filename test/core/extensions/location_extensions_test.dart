import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:solar_energy_prediction/core/extensions/location_extensions.dart';

void main() {
  test('''GIVEN a coordinate 
  WHEN #isDefaultPoint is called
  THEN it returns true when coordinate is (0, 0)''', () {
    // GIVEN
    const coordinate = LatLng(0, 0);

    // WHEN
    final defaultPoint = coordinate.isDefaultPoint();

    // THEN
    expect(defaultPoint, isTrue);
  });

  test('''GIVEN a coordinate 
  WHEN #isDefaultPoint is called
  THEN it returns false when coordinate is different from (0, 0)''', () {
    // GIVEN
    const coordinate = LatLng(4.234, 72.753);

    // WHEN
    final defaultPoint = coordinate.isDefaultPoint();

    // THEN
    expect(defaultPoint, isFalse);
  });
}
