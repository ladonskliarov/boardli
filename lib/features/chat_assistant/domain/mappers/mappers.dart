import '../../data/models/chat_message.dart';
import '../entities/chat_message_entity.dart';

extension ChatMessageMapper on ChatMessage {
  ChatMessageEntity toEntity() {
    return ChatMessageEntity(
      id: DateTime.now().toString(),
      text: content,
      sender: sender,
      sources: sources,
    );
  }
}