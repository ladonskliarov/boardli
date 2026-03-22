import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/mappers/mappers.dart';
import '../../domain/repositories/chat_assistant_repository.dart';
import '../datasource/chat_assistant_datasource.dart';
import '../models/chat_message.dart';

class ChatAssistantRepositoryImpl implements ChatAssistantRepository {
  final ChatAssistantDatasource datasource;
  const ChatAssistantRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, ChatMessageEntity>> sendMessage({
    required String message,
  }) async {
    try {
      final chatMessage = await datasource.sendMessage(message: message);
      return Right(chatMessage.toEntity());
    } catch (e) {
      return Left(ServerFailure('Internal server error'));
    }
  }

  @override
  Future<Either<Failure, List<ChatMessageEntity>>> getChatHistory() async {
    try {
      final chatHistory = await datasource.getChatHistory();
      return Right(chatHistory.map((message) => message.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure('Internal server error'));
    }
  }
}
