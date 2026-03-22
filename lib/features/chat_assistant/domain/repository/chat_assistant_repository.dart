import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/chat_message.dart';

abstract class ChatAssistantRepository {
  Future<Either<Failure, ChatMessageEntity>> sendMessage({required String message});
}