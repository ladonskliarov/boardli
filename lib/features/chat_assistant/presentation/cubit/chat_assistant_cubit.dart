import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/chat_message.dart';
import '../../data/models/source.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../../domain/repositories/chat_assistant_repository.dart';

part 'chat_assistant_state.dart';

class ChatAssistantCubit extends Cubit<ChatState> {
  final ChatAssistantRepository repository;

  ChatAssistantCubit({required this.repository}) : super(const ChatState());

  Future<void> loadChatHistory() async {
    emit(ChatLoadingState());
    final result = await repository.getChatHistory();
    
    result.fold(
      (failure) => emit(ChatState(messages: [])),
      (messages) => emit(ChatState(messages: messages)),
    );
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final userMessage = ChatMessageEntity(
      id: DateTime.now().toString(),
      text: text,
      sender: MessageSender.user,
    );
    
    final botLoadingId = '${DateTime.now().toString()}_bot';
    final botLoadingMessage = ChatMessageEntity(
      id: botLoadingId,
      text: '',
      sender: MessageSender.bot,
      isLoading: true,
    );

    emit(ChatState(messages: [botLoadingMessage, userMessage, ...state.messages]));

    final result = await repository.sendMessage(message: text);

    result.fold(
      (failure) {
        _updateBotMessage(botLoadingId, 'Помилка: ${failure.message}', false, []);
      },
      (response) {
        _updateBotMessage(botLoadingId, response.text, false, []);
      },
    );
  }

  void _updateBotMessage(String id, String newText, bool isLoading, List<Source> sources) {
    final updatedMessages = state.messages.map((message) {
      if (message.id == id) {
        return message.copyWith(text: newText, isLoading: isLoading, sources: sources);
      }
      return message;
    }).toList();

    emit(ChatState(messages: updatedMessages));
  }

  Future<void> refreshChat() async {
    final result = await repository.getChatHistory();
    
    result.fold(
      (failure) => emit(ChatState(messages: [])),
      (messages) => emit(ChatState(messages: messages)),
    );
  }
}
