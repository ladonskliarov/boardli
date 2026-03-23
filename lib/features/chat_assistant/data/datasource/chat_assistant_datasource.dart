import 'package:dio/dio.dart';

import '../models/chat_message.dart';

class ChatAssistantDatasource {
  final Dio dio;
  const ChatAssistantDatasource({required this.dio});

  Future<ChatMessage> sendMessage({required String message}) async {
    const String url = '/api/v1/ai/chat';

    final Map<String, dynamic> requestData = {
      "query": message,
    };

    final response = await dio.post(url, data: requestData);

    return ChatMessage.fromJson(response.data);
  }

  // Future<ChatMessage> generateWelcomeMessage() async {
  //   const String url = '/api/v1/ai/welcome';

  //   final response = await dio.get(url);
  //   return ChatMessage.fromJson(response.data);
  // }

  Future<List<ChatMessage>> getChatHistory() async {
    const String url = '/api/v1/ai/history';

    final response = await dio.get(url);

    final List<dynamic> data = response.data as List<dynamic>;

    return data
        .map((item) => ChatMessage.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}