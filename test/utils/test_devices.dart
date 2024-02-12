import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

class TestDevices {
  static const _textMax = 3.1;

  // Source: https://www.ios-resolution.com/
  static const iphoneSE2ndGen = Device(
    size: Size(375, 667),
    name: 'iphone_se_2nd_gen',
  );

  static const iphoneSE2ndGenTextMax = Device(
    size: Size(375, 667),
    name: 'iphone_se_2nd_gen_text_max',
    textScale: _textMax,
  );

  static const iphone13ProMax = Device(
    size: Size(428, 926),
    name: 'iphone_13_pro_max',
  );

  static const iphone13ProMaxTextMax = Device(
    size: Size(428, 926),
    name: 'iphone_13_pro_max_text_max',
    textScale: _textMax,
  );

  static const List<Device> iosDevices = [
    iphoneSE2ndGen,
    iphone13ProMax,
    iphoneSE2ndGenTextMax,
    iphone13ProMaxTextMax,
  ];
}
