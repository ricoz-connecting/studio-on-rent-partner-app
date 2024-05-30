import 'package:socket_io_client/socket_io_client.dart';
import 'package:studio_partner_app/src/commons/usecases/usecases.dart';
import 'package:studio_partner_app/src/features/chat/domain/entity/message_entity.dart';
import 'package:studio_partner_app/src/features/chat/domain/repository/chat_repository.dart';

class ChatUsecase implements Usecases<Socket, MessageEntity> {
  final ChatRepository chatRepository;

  ChatUsecase({required this.chatRepository});
  @override
  MessageEntity call(Socket params) {
    // TODO: implement call

    return chatRepository.getMessages(params);
  }
}
