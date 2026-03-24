import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../di/injection_container.dart';
import '../storage/interfaces/local_storage_service.dart';

class LocaleProvider extends ChangeNotifier {
  final LocalStorageService localStorageService = sl<LocalStorageService>();
  Locale currentLocale;

  LocaleProvider({required this.currentLocale});

  bool get isUkrainian => currentLocale.languageCode == 'uk';

  Future<void> switchLocale(BuildContext context) async {
    final newLocale = isUkrainian ? const Locale('en') : const Locale('uk');
    currentLocale = newLocale;
    
    await localStorageService.setLocale(newLocale.languageCode);
    
    if (!context.mounted) return;
    await context.setLocale(newLocale);
    
    notifyListeners();
  }
}