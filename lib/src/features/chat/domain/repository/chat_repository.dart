import 'package:socket_io_client/socket_io_client.dart';
import 'package:studio_partner_app/src/features/chat/domain/entity/message_entity.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';

abstract interface class ChatRepository {
  MessageEntity getMessages(Socket socket);
}
