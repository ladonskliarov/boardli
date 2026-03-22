import '../../data/models/chat_message.dart';

extension ChatMessageMapper on ChatMessage {
  ChatMessageEntity toEntity() {
    return ChatMessageEntity(
      id: DateTime.now().toString(),
      text: answer,
      sender: MessageSender.bot,
    );
  }
}