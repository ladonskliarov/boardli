import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

extension PixelSizerExt on num {
  // iPhone 16 logical sizes (pt) used as the design seed
  static const double designHeight = 827;
  static const double designWidth = 381;

  double get ph => this / designHeight * Device.height;

  double get pw => this / designWidth * Device.width;

  double get pMax => max(ph, pw);
}

extension LocaleContentExtension on BuildContext {
  bool get isUkrainian => locale.languageCode == 'uk';
  
  void toggleLocale() {
    final newLocale = isUkrainian ? Locale('en', 'US') : Locale('uk', 'UA');
    setLocale(newLocale);
  }
}