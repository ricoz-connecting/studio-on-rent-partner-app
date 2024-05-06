import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'package:studio_partner_app/src/commons/views/widgets/simple_app_bar.dart';
import 'package:studio_partner_app/src/features/chat/presentation/pages/chat_page.dart';
import 'package:studio_partner_app/src/res/colors.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_list_tile.dart';

class ChatTab extends StatefulWidget {
  const ChatTab({super.key});

  @override
  State<ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          CustomListTile(
            onTap: () {
              context.push(ChatPage.routePath);
            },
          ),
          CustomListTile(
            onTap: () {},
          ),
          CustomListTile(
            onTap: () {},
          ),
          CustomListTile(
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
