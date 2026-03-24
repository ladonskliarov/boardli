import 'package:boardli/features/chat_assistant/data/models/source.dart';

enum MessageSender { user, bot }

class ChatMessage {
  final String content;
  final MessageSender sender;
  final List<Source>? sources;

  const ChatMessage({
    required this.content,
    required this.sender,
    this.sources,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    final isBot = json['role'] == 'assistant';

    return ChatMessage(
      content: json['content'] as String,
      sender: isBot ? MessageSender.bot : MessageSender.user,
      sources: isBot && json['sources'] != null
          ? (json['sources'] as List<dynamic>)
              .map((e) => Source.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }
}
