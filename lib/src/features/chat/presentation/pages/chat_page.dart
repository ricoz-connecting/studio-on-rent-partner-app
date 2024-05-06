import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/commons/views/widgets/simple_app_bar.dart';
import 'package:studio_partner_app/src/core/themes/theme.dart';
import 'package:studio_partner_app/src/features/chat/presentation/widgets/message_box.dart';

class ChatPage extends StatefulWidget {
  static const routePath = '/chat-page';
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.bounceIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;

    return Scaffold(
        appBar: SimpleAppBar(
          bgColor: color.secondary,
          title: 'ID:12345',
          centerTitle: false,
        ),
        backgroundColor: color.surface,
        body: Column(
          children: [
            Expanded(
              child: ListView(
                controller: scrollController,
                children: const [
                  MessageBubble(
                      isMe: true,
                      message: 'message',
                      searchString: 'searchString'),
                  MessageBubble(
                      isMe: true,
                      message: 'message',
                      searchString: 'searchString'),
                  MessageBubble(
                      isMe: true,
                      message: 'message',
                      searchString: 'searchString'),
                  MessageBubble(
                      isMe: false,
                      message: 'message',
                      searchString: 'searchString'),
                  MessageBubble(
                      isMe: true,
                      message: 'message',
                      searchString: 'searchString'),
                  MessageBubble(
                      isMe: true,
                      message: 'message',
                      searchString: 'searchString'),
                  MessageBubble(
                      isMe: true,
                      message: 'message',
                      searchString: 'searchString'),
                  MessageBubble(
                      isMe: true,
                      message: 'message',
                      searchString: 'searchString'),
                  MessageBubble(
                      isMe: true,
                      message: 'message',
                      searchString: 'searchString'),
                  MessageBubble(
                      isMe: true,
                      message: 'message',
                      searchString: 'searchString'),
                  MessageBubble(
                      isMe: true,
                      message: 'message',
                      searchString: 'searchString'),
                  MessageBubble(
                      isMe: false,
                      message: 'message',
                      searchString: 'searchString'),
                  MessageBubble(
                      isMe: false,
                      message: 'message',
                      searchString: 'searchString'),
                ],
              ),
            ),
            _messageInput(color)
          ],
        ));
  }

  Align _messageInput(ColorScheme color) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: color.surface,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  color: color.onSecondary, offset: Offset(0, 0), blurRadius: 6)
            ]),
        child: TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(15),
            hintText: "Type your message",
            fillColor: color.primary,
            border: InputBorder.none,
            suffixIconColor: color.primary,
            suffixIcon: Icon(Icons.send),
          ),
        ),
      ),
    );
  }
}
