import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../interfaces/secure_local_storage.dart';

class SecureLocalStorageImpl implements SecureLocalStorage {
  final FlutterSecureStorage secureStorage;

  SecureLocalStorageImpl({required this.secureStorage});

  static const String _tokenKey = 'access_token';

  @override
  Future<void> saveToken(String token) async {
    await secureStorage.write(key: _tokenKey, value: token);
  }

  @override
  Future<String?> getToken() async {
    return await secureStorage.read(key: _tokenKey);
  }

  @override
  Future<void> deleteToken() async {
    await secureStorage.delete(key: _tokenKey);
  }
}