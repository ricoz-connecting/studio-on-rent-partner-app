import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:studio_partner_app/src/commons/globals/agent_details.dart';
import 'package:studio_partner_app/src/commons/views/widgets/simple_app_bar.dart';
import 'package:studio_partner_app/src/core/themes/theme.dart';
import 'package:studio_partner_app/src/features/chat/data/model/message_model.dart';
import 'package:studio_partner_app/src/features/chat/presentation/widgets/message_box.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_extension_methods.dart';
import 'package:uuid/uuid.dart';

class ChatPage extends StatefulWidget {
  static const routePath = '/chat-page';
  final Socket socket;
  final String uuid;
  const ChatPage({super.key, required this.socket, required this.uuid});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ScrollController scrollController;
  TextEditingController messageController = TextEditingController();
  final List<MessageBubble> messageBubbles = [];

  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

//  [
//     MessageBubble(isMe: true, message: 'message', searchString: 'searchString'),
//     MessageBubble(isMe: true, message: 'message', searchString: 'searchString'),
//     MessageBubble(isMe: true, message: 'message', searchString: 'searchString'),
//     MessageBubble(
//         isMe: false, message: 'message', searchString: 'searchString'),
//     MessageBubble(isMe: true, message: 'message', searchString: 'searchString'),
//     MessageBubble(isMe: true, message: 'message', searchString: 'searchString'),
//     MessageBubble(isMe: true, message: 'message', searchString: 'searchString'),
//     MessageBubble(isMe: true, message: 'message', searchString: 'searchString'),
//     MessageBubble(isMe: true, message: 'message', searchString: 'searchString'),
//     MessageBubble(isMe: true, message: 'message', searchString: 'searchString'),
//     MessageBubble(isMe: true, message: 'message', searchString: 'searchString'),
//     MessageBubble(
//         isMe: false, message: 'message', searchString: 'searchString'),
//     MessageBubble(
//         isMe: false, message: 'message', searchString: 'searchString'),
//   ];
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    scrollController = ScrollController();
    widget.socket.emit('chat', globalAgentId);
    socketsFunctions();
  }

  socketsFunctions() {
    widget.socket.on('chat', (data) {
      log(data.toString());
      final decodedData = data.runtimeType == String
          ? List<Map<String, dynamic>>.from(jsonDecode(data))
          : List<Map<String, dynamic>>.from(data);
      final messages = decodedData
          .map<MessageBubble>(
              (e) => MessageBubble(messageModel: MessageModel.fromMap(e)))
          .toList();
      if (mounted) {
        setState(() {
          messageBubbles.addAll(messages);
        });
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.animateTo(scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.bounceIn);
        }
      });
    });

    widget.socket.on('message', (data) {
      log(data.toString());
      final message = data.runtimeType == String ? jsonDecode(data) : data;
      final MessageModel messageModel = MessageModel.fromMap(message);
      if (mounted) {
        setState(() {
          messageBubbles.addAll([
            MessageBubble(
              messageModel: messageModel,
            ),
          ]);
        });
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.animateTo(scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.bounceIn);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;

    return Scaffold(
        appBar: SimpleAppBar(
          bgColor: color.secondary,
          title: widget.uuid,
          centerTitle: false,
        ),
        backgroundColor: color.surface,
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
              controller: scrollController,
              itemBuilder: (context, index) => messageBubbles[index],
              itemCount: messageBubbles.length,
            )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: color.surface,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                          color: color.onSecondary,
                          offset: const Offset(0, 0),
                          blurRadius: 6)
                    ]),
                child: TextField(
                  controller: messageController,
                  onSubmitted: (data) {
                    log(messageController.text);
                  },
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(15),
                      hintText: "Type your message",
                      fillColor: color.primary,
                      border: InputBorder.none,
                      suffixIconColor: color.primary,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          log(messageController.text);
                          final message = MessageModel(
                              id: const Uuid().v4(),
                              isMe: false,
                              agentID: globalAgentId,
                              uuid: widget.uuid,
                              message: messageController.text,
                              timestamp: DateTime.now());

                          setState(() {
                            messageBubbles.add(MessageBubble(
                              messageModel: message,
                            ));
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if (scrollController.hasClients) {
                                scrollController.animateTo(
                                    scrollController.position.maxScrollExtent,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.bounceIn);
                              }
                            });
                          });
                          widget.socket.emit('messageA', message.toJson());
                          messageController.clear();
                        },
                      )),
                ),
              ),
            )
          ],
        ));
  }
}
