import '../../util/enums.dart';

abstract class TokenRepository {
  Future<void> initToken();
  Future<void> saveToken({required String token, required UserType userType});
  String? getToken();
  UserType? getCachedUserType();
  Future<void> deleteToken();
  bool get hasToken;
}