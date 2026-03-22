part of 'chat_assistant_cubit.dart';

class ChatState extends Equatable{
  final List<ChatMessageEntity> messages;
  const ChatState({this.messages = const []});

  @override
  List<Object> get props => [messages];
}
// sealed class ChatAssistantState extends Equatable {
//   const ChatAssistantState();

//   @override
//   List<Object> get props => [];
// }

// final class ChatAssistantInitial extends ChatAssistantState {}

// final class ChatAssistantLoading extends ChatAssistantState {}

// final class ChatAssistantLoaded extends ChatAssistantState {
//   final String response;

//   const ChatAssistantLoaded({required this.response});

//   @override
//   List<Object> get props => [response];
// }

// final class ChatAssistantFailure extends ChatAssistantState {
//   final String message;

//   const ChatAssistantFailure({required this.message});

//   @override
//   List<Object> get props => [message];
// }
