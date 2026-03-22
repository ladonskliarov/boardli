import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../../../authorization/data/models/employee.dart';

class CompanyManagementDatasource {
  final Dio dio;
  CompanyManagementDatasource({required this.dio});

  Future<List<BaseEmployee>?> getEmployees() async {
    const String url = '/api/v1/employees';

    try {
      final response = await dio.get(url);

      log('Get employees status code: ${response.statusCode}');
      log('Response data: ${response.data}');

      final data = response.data;

      return data.map<BaseEmployee>((json) {
        if (json['status'] == 'pending') {
          return InvitedEmployee.fromJson(json);
        } else {
          return Employee.fromJson(json);
        }
      }).toList();
    } on DioException catch (e) {
      log('Get employees error: ${e.response?.statusCode}');
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

  Future<List<String>?> getDepartments() async {
    const String url = '/api/v1/companies/me/departments';

    try {
      final response = await dio.get(url);

      log('Get departments status code: ${response.statusCode}');
      log('Response data: ${response.data}');
      
      final data = response.data;

      return data.map<String>((json) => json as String).toList();
   
    } on DioException catch (e) {
      log('Get departments error: ${e.response?.statusCode}');
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

  Future<String> createEmployeeInvite({
    required String name,
    required String email,
    required String department,
    required String role,
  }) async {
    const String url = '/api/v1/companies/invite-employee';

    final Map<String, dynamic> requestData = {
      "name": name,
      "email": email,
      "department": department,
      "role": role,
    };

    try {
      final response = await dio.post(url, data: requestData);

      log('Invite employee status code: ${response.statusCode}');
      log('Response data: ${response.data}');
      final String urlString = response.data['inviteLink'];
      final uri = Uri.parse(urlString);

      return uri.queryParameters['token']!;
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

  Future<List<String>> createDepartment({required String department}) async {
    const String url = '/api/v1/companies/me/departments';

    final Map<String, dynamic> requestData = {
      "name": department,
    };

    try {
      final response = await dio.post(url, data: requestData);

      log('Create department status code: ${response.statusCode}');
      log('Response data: ${response.data}');

      final data = response.data['departments'];
      return data.map<String>((json) => json as String).toList();

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
}
