import 'package:flutter_test/flutter_test.dart';
import 'package:solar_energy_prediction/core/extensions/string_extensions.dart';

void main() {
  test('''GIVEN a degrees string number 
  WHEN #addCelsiusSymbol is called
  THEN it returns the number with celsius symbol as postfix''', () {
    // GIVEN
    const degrees = '60';
    const degreesSymbol = '°C';

    expect(degrees.contains(degreesSymbol), isFalse);

    // WHEN
    final degreesWithCelsiusSymbol = degrees.addCelsiusSymbol();

    // THEN
    expect(degreesWithCelsiusSymbol.contains(degreesSymbol), isTrue);
  });
}
