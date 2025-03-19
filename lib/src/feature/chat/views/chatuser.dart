// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:studio_partner_app/src/feature/chat/controller/chat_controller.dart';
// import 'package:studio_partner_app/src/feature/chat/repository/chat_repository.dart';

// import 'package:studio_partner_app/src/feature/chat/sockets/chat_socket.dart';

// class ChatScreenUser extends ConsumerStatefulWidget {
//   final String userId;
//   final String partnerId;

//   const ChatScreenUser(
//       {Key? key, required this.userId, required this.partnerId})
//       : super(key: key);

//   @override
//   _ChatScreenUserState createState() => _ChatScreenUserState();
// }

// class _ChatScreenUserState extends ConsumerState<ChatScreenUser> {
//   final TextEditingController _messageController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   String? chatRoomId;
//   bool isTyping = false;

//   @override
//   void initState() {
//     super.initState();
//     _initializeChat();
//     ref.read(socketServiceProvider).onNewMessage(_onMessageReceived);
//     ref.read(socketServiceProvider).onUserTyping(_onUserTyping);
//     ref.read(socketServiceProvider).onUserStoppedTyping(_onUserStoppedTyping);
//   }

//   Future<void> _initializeChat() async {
//     chatRoomId = await ref
//         .read(chatRepoProvider)
//         .getOrCreateChatRoom(widget.userId, widget.partnerId);
//     if (chatRoomId != null) {
//       await ref
//           .read(chatControllerProvider.notifier)
//           .getChatMessages(chatRoomId!);
//     }
//   }

//   void _onMessageReceived(Map<String, dynamic> message) {
//     ref.read(chatControllerProvider.notifier).sendMessage(
//           chatRoomId!,
//           message['senderId'],
//           message['text'],
//         );
//     _scrollToBottom();
//   }

//   void _onUserTyping(Map<String, dynamic> data) {
//     if (data['userId'] == widget.partnerId) {
//       setState(() {
//         isTyping = true;
//       });
//     }
//   }

//   void _onUserStoppedTyping(Map<String, dynamic> data) {
//     if (data['userId'] == widget.partnerId) {
//       setState(() {
//         isTyping = false;
//       });
//     }
//   }

//   void _sendMessage() {
//     if (_messageController.text.trim().isEmpty || chatRoomId == null) return;

//     ref.read(socketServiceProvider).sendMessage(
//           chatRoomId!,
//           widget.userId,
//           widget.partnerId,
//           _messageController.text.trim(),
//         );
//     ref.read(chatControllerProvider.notifier).sendMessage(
//           chatRoomId!,
//           widget.userId,
//           _messageController.text.trim(),
//         );

//     _messageController.clear();
//   }

//   void _scrollToBottom() {
//     Future.delayed(Duration(milliseconds: 300), () {
//       _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final messages = ref.watch(chatControllerProvider);

//     return Scaffold(
//       appBar: AppBar(title: Text("Chat with Partner")),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               controller: _scrollController,
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 final message = messages[index];
//                 return ListTile(
//                   title: Text(message.text!),
//                   subtitle: Text(
//                       message.senderId == widget.userId ? "You" : "Partner"),
//                   trailing: message.senderId == widget.userId
//                       ? Icon(Icons.check)
//                       : null,
//                 );
//               },
//             ),
//           ),
//           if (isTyping)
//             Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text("Partner is typing...")),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     onChanged: (text) {
//                       ref.read(socketServiceProvider).typingEvent(
//                           chatRoomId!, widget.userId, text.isNotEmpty);
//                     },
//                     decoration: InputDecoration(hintText: "Type a message..."),
//                   ),
//                 ),
//                 IconButton(icon: Icon(Icons.send), onPressed: _sendMessage),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:studio_partner_app/src/feature/chat/controller/chat_controller.dart';
import 'package:studio_partner_app/src/feature/chat/repository/chat_repository.dart';
import 'package:studio_partner_app/src/feature/chat/sockets/chat_socket.dart';

class ChatScreenUser extends ConsumerStatefulWidget {
  final String partnerId;
  final String userId;

  const ChatScreenUser({
    Key? key,
    required this.partnerId,
    required this.userId,
  }) : super(key: key);

  @override
  _ChatScreenUserState createState() => _ChatScreenUserState();
}

class _ChatScreenUserState extends ConsumerState<ChatScreenUser> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String? chatRoomId;
  bool isTyping = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeChat();
      final socket = ref.read(socketServiceProvider);
      socket.connect(widget.partnerId);
      socket.onNewMessage(_onMessageReceived);
      socket.onUserTyping(_onUserTyping);
      socket.onUserStoppedTyping(_onUserStoppedTyping);
    });
  }

  Future<void> _initializeChat() async {
    chatRoomId = await ref
        .read(chatRepoProvider)
        .getOrCreateChatRoom(widget.userId, widget.partnerId);

    if (chatRoomId != null) {
      await ref
          .read(chatControllerProvider.notifier)
          .getChatMessages(chatRoomId!);
    }
  }

  void _onMessageReceived(Map<String, dynamic> message) {
    ref.read(chatControllerProvider.notifier).sendMessage(
          chatRoomId!,
          message['senderId'],
          message['text'],
        );
    _scrollToBottom();
  }

  void _onUserTyping(Map<String, dynamic> data) {
    setState(() {
      isTyping = true;
    });
  }

  void _onUserStoppedTyping(Map<String, dynamic> data) {
    setState(() {
      isTyping = false;
    });
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty || chatRoomId == null) return;

    ref.read(socketServiceProvider).sendMessage(
          chatRoomId!,
          widget.userId,
          widget.partnerId,
          text,
        );
    ref.read(chatControllerProvider.notifier).sendMessage(
          chatRoomId!,
          widget.userId,
          text,
        );
    _messageController.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final bool isSentByUser = message.senderId == widget.userId;

                return Align(
                  alignment: isSentByUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      color:
                          isSentByUser ? Colors.blueAccent : Colors.grey[300],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomLeft:
                            isSentByUser ? Radius.circular(12) : Radius.zero,
                        bottomRight:
                            isSentByUser ? Radius.zero : Radius.circular(12),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          message.text ?? "",
                          style: TextStyle(
                            color: isSentByUser ? Colors.white : Colors.black87,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          DateFormat('hh:mm a').format(message.createdAt!),
                          style: TextStyle(
                            color:
                                isSentByUser ? Colors.white70 : Colors.black54,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (isTyping)
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("User is typing...",
                  style: TextStyle(fontStyle: FontStyle.italic)),
            ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Text("$isTyping"),
          Expanded(
            child: TextField(
              controller: _messageController,
              onChanged: (text) {
                final socket = ref.read(socketServiceProvider);
                if (text.isNotEmpty) {
                  socket.typingEvent(chatRoomId!, widget.userId, true);
                } else {
                  socket.typingEvent(chatRoomId!, widget.userId, false);
                }
              },
              decoration: InputDecoration(
                hintText: "Type a message...",
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: _sendMessage,
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.blueAccent,
              child: Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
