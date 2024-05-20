import 'package:studio_partner_app/src/features/chat/domain/entity/message_entity.dart';
import 'package:studio_partner_app/src/features/chat/domain/repository/chat_repository.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';

class ChatRepositoryImpl implements ChatRepository{
  @override
  StreamEitherFailure<MessageEntity> getMessages(String agentId) {
    // TODO: implement getMessages
    throw UnimplementedError();
  }
}