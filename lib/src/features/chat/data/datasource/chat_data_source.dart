// import 'dart:convert';
// import 'dart:developer';

// import 'package:socket_io_client/socket_io_client.dart';
// import 'package:studio_partner_app/src/features/chat/data/model/message_model.dart';
// import 'package:studio_partner_app/src/res/strings.dart';

// abstract interface class ChatDataSource {
//   MessageModel getMessage(Socket socket);
// }

// class ChatDataSourceImpl implements ChatDataSource {
//   late MessageModel _messageModel;
//   @override
//   MessageModel getMessage(Socket socket) {
//     socket.on('message', (data) {
//       log(data);
//       final message = jsonDecode(data);
//       final MessageModel messageModel = MessageModel.fromMap(message);
//       _messageModel = messageModel;
//     });
//     return _messageModel;
//   }
// }
