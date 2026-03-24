part of 'chat_assistant_cubit.dart';

class ChatState extends Equatable{
  final List<ChatMessageEntity> messages;
  const ChatState({this.messages = const []});

  @override
  List<Object> get props => [messages];
}

class ChatLoadingState extends ChatState {}
