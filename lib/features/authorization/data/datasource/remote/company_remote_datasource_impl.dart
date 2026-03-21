import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../../core/error/failures.dart';
import '/features/authorization/data/models/company.dart';
import 'company_remote_datasource.dart';

class CompanyRemoteDatasourceImpl extends CompanyRemoteDatasource {
  final Dio dio;
  CompanyRemoteDatasourceImpl({required this.dio});

  @override
  Future<({Company company, String token})> login({
    required String email,
    required String password,
  }) async {
    const String url = '/api/v1/auth/company/login';

    final Map<String, dynamic> requestData = {
      "email": email,
      "password": password,
    };

    try {
      final response = await dio.post(url, data: requestData);

      log('Login status code: ${response.statusCode}');
      log('Response data: ${response.data}');

      return (
        company: Company.fromJson(response.data['user']),
        token: response.data['accessToken'] as String,
      );
    } on DioException catch (e) {
      log('Login error: ${e.response?.statusCode}');
      log('Server message: ${e.response?.data}');

      final String errorMessage =
          e.response?.data?['message'] ??
          'Login failed. Code: ${e.response?.statusCode}';

      throw ServerFailure(errorMessage);
    } catch (e) {
      log('Critical login error: $e');
      throw ServerFailure('Unexpected error occurred: $e');
    }
  }

  @override
  Future<({Company company, String token})> register({
    required String name,
    required String industry,
    required String size,
    required String contactName,
    required String email,
    required String password,
  }) async {
    const String url = '/api/v1/auth/company/register';

    final Map<String, dynamic> requestData = {
      "name": name,
      "industry": industry,
      "size": size,
      "contactName": contactName,
      "email": email,
      "password": password,
    };

    try {
      final response = await dio.post(url, data: requestData);

      log('Registration status code: ${response.statusCode}');
      log('Response data: ${response.data}');

      return (
        company: Company.fromJson(response.data['user']),
        token: response.data['accessToken'] as String,
      );
    } on DioException catch (e) {
      log('Registration error: ${e.response?.statusCode}');
      log('Server message: ${e.response?.data}');

      final String errorMessage =
          e.response?.data?['message'] ??
          'Registration failed. Code: ${e.response?.statusCode}';

      throw ServerFailure(errorMessage);
    } catch (e) {
      log('Critical registration error: $e');
      throw ServerFailure('Unexpected error occurred: $e');
    }
  }

  @override
  Future<Company> getMe() async {
    final response = await dio.get('/api/v1/auth/me');
    return Company.fromJson(response.data);
  }
}
