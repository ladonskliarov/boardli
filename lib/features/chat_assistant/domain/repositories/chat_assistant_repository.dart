import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/chat_message_entity.dart';

abstract class ChatAssistantRepository {
  Future<Either<Failure, ChatMessageEntity>> sendMessage({required String message});
  Future<Either<Failure, List<ChatMessageEntity>>> getChatHistory();
}