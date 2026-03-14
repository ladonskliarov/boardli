import 'package:flutter/material.dart';

import '../di/injection_container.dart';
import '../storage/interfaces/local_storage_service.dart';

class ThemeProvider extends ChangeNotifier {
  bool darkTheme;
  ThemeProvider({required this.darkTheme});

  final LocalStorageService localStorageService = di<LocalStorageService>();

  void switchDarkTheme() {
    localStorageService.setDarkTheme(!darkTheme).then((_) {
      darkTheme = !darkTheme;
      notifyListeners();
    });
  }
}