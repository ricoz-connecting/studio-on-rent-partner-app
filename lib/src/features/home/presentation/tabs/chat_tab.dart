import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_partner_app/src/commons/globals/agent_details.dart';

import 'package:studio_partner_app/src/commons/views/widgets/simple_app_bar.dart';
import 'package:studio_partner_app/src/features/chat/presentation/pages/chat_page.dart';
import 'package:studio_partner_app/src/features/home/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:studio_partner_app/src/res/colors.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_list_tile.dart';

class ChatTab extends StatefulWidget {
  const ChatTab({super.key});

  @override
  State<ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ChatBloc>().add(GetChatEvent(agentId: globalAgentId));
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is ChatSuccessState) {
            if (state.chats.isEmpty) {
              return Center(
                child: Text("No Data to Show"),
              );
            }
            return ListView.builder(
                itemBuilder: (context, index) => CustomListTile(
                      onTap: () {
                        context.push(ChatPage.routePath);
                      },
                      chatEntity: state.chats[index],
                    ));
          } else if (state is ChatLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
