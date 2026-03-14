import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../storage/implementations/shared_prefs_storage.dart';

final GetIt di = GetIt.instance;

Future<void> initDI() async {
  await SharedPreferences.getInstance();
  _registerLocalStorages();
}

void _registerLocalStorages() {
  di.registerLazySingleton(<LocalStorageService>() => SharedPrefsStorage());
}