import 'package:flutter/material.dart';

import '../di/injection_container.dart';
import '../storage/interfaces/local_storage_service.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkTheme;
  ThemeProvider({required this.isDarkTheme});

  final LocalStorageService localStorageService = sl<LocalStorageService>();

  void switchDarkTheme() {
    localStorageService.setDarkTheme(!isDarkTheme).then((_) {
      isDarkTheme = !isDarkTheme;
      notifyListeners();
    });
  }
}