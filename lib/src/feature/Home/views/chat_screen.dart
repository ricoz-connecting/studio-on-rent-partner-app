import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/commons/views/appbar.dart';
import 'package:studio_partner_app/commons/views/providers/authprovider.dart';
import 'package:studio_partner_app/src/feature/Home/views/empty_chat.dart';
import 'package:studio_partner_app/src/feature/chat/views/chatroom.dart';
import 'package:studio_partner_app/src/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(statusProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Appbar.buildAppBar(context, ref),
      body: status?.kycStatus != 'Success'
          ? const EmptyChat()
          : const ChatScreenBody(),
    );
  }
}

class ChatScreenBody extends StatelessWidget {
  const ChatScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('dd/MM/yyyy').format(now);
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Chats(
            height: height, width: width, formattedTime: formattedTime);
      },
    );
  }
}

class Chats extends StatelessWidget {
  const Chats({
    super.key,
    required this.height,
    required this.width,
    required this.formattedTime,
  });

  final double height;
  final double width;
  final String formattedTime;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Chatroom(),
            ));
        log('switching chatscreen to chat room');
      },
      child: Container(
        color: const Color(0xFFF4F6F9),
        // height: height * 0.08,
        // width: width * 0.9,

        margin: EdgeInsets.all(
          width * 0.015,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 5,
            ),
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.png'),
              radius: 25,
            ),
            Container(
              color: const Color(0xFFF4F6F9),
              width: width * 0.82,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ID: 12345',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 16,
                              letterSpacing: 0.13,
                              color: BasicColor.deepBlack,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      Text(formattedTime)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          'HELLO',
                          maxLines: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width * 0.1),
                        child: const Icon(
                          Icons.check,
                          size: 15,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
