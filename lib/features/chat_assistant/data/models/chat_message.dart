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

class ChatMessageEntity {
  final String id;
  final String text;
  final MessageSender sender;
  final bool isLoading;
  final List<Source>? sources;

  const ChatMessageEntity({
    required this.id,
    required this.text,
    required this.sender,
    this.isLoading = false,
    this.sources,
  });

  factory ChatMessageEntity.fromModel(String id, ChatMessage model) {
    return ChatMessageEntity(
      id: id,
      text: model.content,
      sender: model.sender,
      sources: model.sources,
    );
  }

  ChatMessageEntity copyWith({
    String? text,
    bool? isLoading,
    List<Source>? sources,
  }) {
    return ChatMessageEntity(
      id: id,
      text: text ?? this.text,
      sender: sender,
      isLoading: isLoading ?? this.isLoading,
      sources: sources ?? this.sources,
    );
  }

}

class Source {
  final String id, title, resourceId, type;

  const Source({
    required this.id,
    required this.title,
    required this.resourceId,
    required this.type,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['resource']['id'] as String,
      title: json['resource']['title'] as String,
      resourceId: json['resource']['id'] as String,
      type: json['resource']['type'] as String,
    );
  }
}