import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../../core/error/failures.dart';
import '/features/authorization/data/models/employee.dart';
import 'employee_remote_datasource.dart';

class EmployeeRemoteDatasourceImpl implements EmployeeRemoteDatasource {
  final Dio dio;
  const EmployeeRemoteDatasourceImpl({required this.dio});

  @override
  Future<({Employee employee, String token})> login({
    required String email,
    required String password,
  }) async {
    const String url = '/api/v1/auth/employee/login';

    final Map<String, dynamic> requestData = {
      "email": email,
      "password": password,
    };

    try {
      final response = await dio.post(url, data: requestData);

      log('Login response: ${response.data}');

      return (
        employee: Employee.fromJson(response.data['user']),
        token: response.data['accessToken'] as String,
      );
    } on DioException catch (e) {
      log('Request error: ${e.response?.statusCode}');
      log('Message: ${e.response?.data}');

      final String errorMessage =
          e.response?.data?['message'] ??
          'Server error. Code: ${e.response?.statusCode}';

      throw ServerFailure(errorMessage);
    } catch (e) {
      log('Unexpected error: $e');
      throw ServerFailure('Unexpected error: $e');
    }
  }

  @override
  Future<({Employee employee, String token})> register({
    required String inviteKey,
    required String password,
    required String gender,
    required String hobbies,
    required String favoriteAnimals,
  }) async {
    const String url = '/api/v1/auth/employee/register';

    final Map<String, dynamic> requestData = {
      "token": inviteKey,
      "password": password,
      "gender": gender,
      "hobbies": hobbies,
      "favoriteAnimal": favoriteAnimals,
    };

    try {
      final response = await dio.post(
        url,
        data: requestData,
        options: Options(headers: {'Authorization': 'Bearer $inviteKey'}),
      );

      log('Register response: ${response.data}');
      // await getAvatar();

      return (
        employee: Employee.fromJson(response.data['user']),
        token: response.data['accessToken'] as String,
      );
    } on DioException catch (e) {
      log('Request error: ${e.response?.statusCode}');
      log('Message: ${e.response?.data}');

      final String errorMessage =
          e.response?.data?['message'] ??
          'Server error. Code: ${e.response?.statusCode}';

      throw ServerFailure(errorMessage);
    } catch (e) {
      log('Unexpected error: $e');
      throw ServerFailure('Unexpected error: $e');
    }
  }

  @override
  Future<Employee> getMe() async {
    try {
      final response = await dio.get('/api/v1/auth/me');

      return Employee.fromJson(response.data);
    } catch (e) {
      log('Unexpected error: $e');
      throw ServerFailure('Unexpected error: $e');
    }
  }

  @override
  Future<String> getAvatar() async {
    try {
      final response = await dio.post('/api/v1/ai/avatar-url');
      log('getAvatar response: ${response.data}');
      return response.data['avatarUrl'] as String;
    } catch (e) {
      log('Unexpected error: $e');
      throw ServerFailure('Unexpected error: $e');
    }
  }
}
