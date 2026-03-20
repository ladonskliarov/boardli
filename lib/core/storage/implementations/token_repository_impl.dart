import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../util/enums.dart';
import '../interfaces/token_repository.dart';

class TokenRepositoryImpl implements TokenRepository {
  final FlutterSecureStorage secureStorage;
  String? _cachedToken;
  UserType? _cachedUserType;

  TokenRepositoryImpl({required this.secureStorage});

  @override
  Future<void> initToken() async {
    _cachedToken = await secureStorage.read(key: 'jwt_token');
    final String? userType = await secureStorage.read(key: 'user_type');
    _cachedUserType = UserType.values.firstWhere((e) => e.name == userType);
  }

  @override
  String? getToken() {
    return _cachedToken;
  }

  @override
  UserType? getCachedUserType() {
    return _cachedUserType;
  }

  @override
  Future<void> saveToken({required String token, required UserType userType}) async {
    _cachedToken = token;
    _cachedUserType = _cachedUserType;

    await secureStorage.write(key: 'jwt_token', value: token);
    await secureStorage.write(key: 'user_type', value: userType.name);
    // final result = _cachedToken = await secureStorage.read(key: 'jwt_token');
    // log('Cached token: $_cachedToken');
    // log('Cached user type: $_cachedUserType');
    // log('System token: $result');
  }

  @override
  Future<void> deleteToken() async {
    _cachedToken = null;
    await secureStorage.delete(key: 'jwt_token');
    await secureStorage.delete(key: 'user_type');
  }

  @override
  bool get hasToken => _cachedToken != null;
}