abstract class LocalStorageService {
  Future<bool> getDarkTheme();
  Future<void> setDarkTheme(bool value);
Future<String> getLocale();
  Future<void> setLocale(String value);
}