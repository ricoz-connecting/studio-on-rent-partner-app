import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/feature/chat/views/chat.dart';
import 'package:studio_partner_app/src/feature/chat/views/chatuser.dart';

class ChatDemo extends StatefulWidget {
  const ChatDemo({super.key});

  @override
  State<ChatDemo> createState() => _ChatDemoState();
}

class _ChatDemoState extends State<ChatDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Ensures content moves up when keyboard appears
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.lightBlue,
                child: const ChatScreenUser(
                  userId: '66cdfa88aec3730b74382069',
                  partnerId: '66d5b71d4e38b24f988e6e25',
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.lightBlue,
                child: const ChatScreenPartner(
                  userId: '66cdfa88aec3730b74382069',
                  partnerId: '66d5b71d4e38b24f988e6e25',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
