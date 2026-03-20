import 'package:dio/dio.dart';

import '../storage/interfaces/token_repository.dart';

class TokenInterceptor extends Interceptor {
  final TokenRepository tokenRepository;
  TokenInterceptor({required this.tokenRepository});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = tokenRepository.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }
}