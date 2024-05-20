import 'package:studio_partner_app/src/features/chat/domain/entity/message_entity.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';

abstract interface class ChatRepository {
  StreamEitherFailure<MessageEntity> getMessages(String agentId);
}
