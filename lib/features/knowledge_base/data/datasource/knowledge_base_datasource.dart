import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../models/resource.dart';

class KnowledgeBaseDatasource {
  final Dio dio;
  const KnowledgeBaseDatasource({required this.dio});

  Future<void> deleteResource(String resourceId) async {
    final String url = '/api/v1/resources/$resourceId';

    try {
      final response = await dio.delete(url);

      log('Delete resource status code: ${response.statusCode}');
      log('Response data: ${response.data}');
    } on DioException catch (e) {
      log('Delete resource error: ${e.response?.statusCode}');
      log('Server message: ${e.response?.data}');

      final String errorMessage =
          e.response?.data?['message'] ??
          'Failed to delete resource. Code: ${e.response?.statusCode}';

      throw Exception(errorMessage);
    } catch (e) {
      log('Critical delete resource error: $e');
      throw Exception('Unexpected error occurred: $e');
    }
  }
  Future<List<Resource>> getResources() async {
    const String url = '/api/v1/resources';

    final response = await dio.get(url);

    log('Get resources status code: ${response.statusCode}');
    log('Response data: ${response.data}');

    final List<Resource> resources = (response.data as List<dynamic>)
        .map((item) => Resource.fromJson(item as Map<String, dynamic>))
        .toList();

    return resources;
  }

  Future<void> uploadLink({required String link, String? title}) async {
    const String url = '/api/v1/resources/url';

    final Map<String, dynamic> requestData = {"url": link, "title": title ?? link};

    try {
      final response = await dio.post(url, data: requestData);

      log('Upload link status code: ${response.statusCode}');
      log('Response data: ${response.data}');
    } on DioException catch (e) {
      log('Upload link error: ${e.response?.statusCode}');
      log('Server message: ${e.response?.data}');

      final String errorMessage =
          e.response?.data?['message'] ??
          'Failed to upload link. Code: ${e.response?.statusCode}';

      throw Exception(errorMessage);
    } catch (e) {
      log('Critical upload link error: $e');
      throw Exception('Unexpected error occurred: $e');
    }
  }

  Future<void> uploadFile(File file) async {
    const String url = '/api/v1/resources/upload';

    final fileName = file.path.split('/').last;

    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: fileName),
    });

    try {
      final response = await dio.post(url, data: formData);

      log('Upload file status code: ${response.statusCode}');
      log('Response data: ${response.data}');
    } on DioException catch (e) {
      log('Upload file error: ${e.response?.statusCode}');
      log('Server message: ${e.response?.data}');

      final String errorMessage =
          e.response?.data?['message'] ??
          'Failed to upload file. Code: ${e.response?.statusCode}';

      throw Exception(errorMessage);
    } catch (e) {
      log('Critical upload file error: $e');
      throw Exception('Unexpected error occurred: $e');
    }
  }
}
