import '../../data/models/chat_message.dart';
import '../../data/models/source.dart';

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
