import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../models/chat_message.dart';
class ChatAssistantDatasource {
  final Dio dio;
  const ChatAssistantDatasource({required this.dio});

  Future<ChatMessage> sendMessage({required String message}) async {
    const String url = '/api/v1/ai/chat';
    final Map<String, dynamic> requestData = {
      "query": message,
    };

    try {
      final response = await dio.post(url, data: requestData);

      log('SendMessage status code: ${response.statusCode}');
      log('Response data: ${response.data}');

      return ChatMessage.fromJson(response.data);
    } on DioException catch (e) {
      log('SendMessage error: ${e.response?.statusCode}');
      log('Server message: ${e.response?.data}');

      final String errorMessage =
          e.response?.data?['message'] ??
          'Failed to send message. Code: ${e.response?.statusCode}';

      throw ServerFailure(errorMessage);
    } catch (e) {
      log('Critical SendMessage error: $e');
      throw ServerFailure('Unexpected error occurred: $e');
    }
  }

  Future<List<ChatMessage>> getChatHistory() async {
    const String url = '/api/v1/ai/history';

    try {
      final response = await dio.get(url);

      log('GetChatHistory status code: ${response.statusCode}');

      final List<dynamic> data = response.data as List<dynamic>;

      return data
          .map((item) => ChatMessage.fromJson(item as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      log('GetChatHistory error: ${e.response?.statusCode}');
      log('Server message: ${e.response?.data}');

      final String errorMessage =
          e.response?.data?['message'] ??
          'Failed to load chat history. Code: ${e.response?.statusCode}';

      throw ServerFailure(errorMessage);
    } catch (e) {
      log('Critical GetChatHistory error: $e');
      throw ServerFailure('Unexpected error occurred: $e');
    }
  }
}