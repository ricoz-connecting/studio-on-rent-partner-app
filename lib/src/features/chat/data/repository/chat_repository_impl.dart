import 'package:socket_io_client/src/socket.dart';
import 'package:studio_partner_app/src/features/chat/data/datasource/chat_data_source.dart';
import 'package:studio_partner_app/src/features/chat/domain/entity/message_entity.dart';
import 'package:studio_partner_app/src/features/chat/domain/repository/chat_repository.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';

class ChatRepositoryImpl implements ChatRepository {
  @override
  MessageEntity getMessages(Socket socket) {
    // TODO: implement getMessages
    throw UnimplementedError();
  }
//   final ChatDataSource chatDataSource;

//   ChatRepositoryImpl({required this.chatDataSource});
//   @override
//   MessageEntity getMessages(Socket socket) {
//     // TODO: implement getMessages
//     return chatDataSource.getMessage(socket);
//   }
}
