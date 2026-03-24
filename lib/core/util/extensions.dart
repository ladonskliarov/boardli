import 'dart:math';

import 'package:responsive_sizer/responsive_sizer.dart';

extension PixelSizerExt on num {
  // iPhone 16 logical sizes (pt) used as the design seed
  static const double designHeight = 827;
  static const double designWidth = 381;

  double get ph => this / designHeight * Device.height;

  double get pw => this / designWidth * Device.width;

  double get pMax => max(ph, pw);
}
