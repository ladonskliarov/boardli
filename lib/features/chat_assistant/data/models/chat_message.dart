enum MessageSender { user, bot }

class ChatMessage {
  final String answer;

  const ChatMessage({
    required this.answer,
  });

  ChatMessage copyWith({
    String? text,
    bool? isLoading,
    List<String>? sources,
  }) {
    return ChatMessage(
      answer: answer,
    );
  }
  
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      answer: json['content'] as String,
    );
  }
  
}

class ChatMessageEntity {
  final String? id;
  final String text;
  final MessageSender sender;
  final bool isLoading;

  const ChatMessageEntity({
    this.id,
    required this.text,
    required this.sender,
    this.isLoading = false,
  });

  ChatMessageEntity copyWith({
    String? text,
    bool? isLoading,
    List<String>? sources,
  }) {
    return ChatMessageEntity(
      text: text ?? this.text,
      sender: sender,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}