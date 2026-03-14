import 'package:shared_preferences/shared_preferences.dart';

import '../interfaces/local_storage_service.dart';
import '../keys/storage_keys.dart';

class SharedPrefsStorage implements LocalStorageService {
  @override
  Future<bool> getDarkTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(StorageKeys.darkThemeKey) ?? false;
  }

  @override
  Future<void> setDarkTheme(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(StorageKeys.darkThemeKey, value);
  }
}