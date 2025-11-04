import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:studio_partner_app/commons/views/providers/authprovider.dart';
import 'package:studio_partner_app/src/feature/chat_screen/controller/list_message_controller.dart';
import 'package:studio_partner_app/src/feature/chat_screen/services/socket_service.dart';
import 'package:studio_partner_app/src/feature/chat_screen/views/message_screen.dart';
import 'package:studio_partner_app/src/res/assets.dart';

class ListOfChatsViews extends ConsumerStatefulWidget {
  final String userId;
  const ListOfChatsViews({super.key, required this.userId});

  @override
  ConsumerState<ListOfChatsViews> createState() => _ListOfChatsViewsState();
}

class _ListOfChatsViewsState extends ConsumerState<ListOfChatsViews> {
  bool isLoading = true;
  final SocketService socketService = SocketService();

  @override
  void initState() {
    super.initState();

    if (!socketService.isConnected) {
      socketService.connect(widget.userId, (updatedChatList) {
        ref
            .read(listOfMessageControllerProvider.notifier)
            .updateMessages(updatedChatList);
      });
    }

    _fetchData();

    // ✅ Listen for incoming messages
    socketService.socket.on("receive_message", (data) {
      _fetchData();
    });

    // ✅ Listen for updated chat list
    socketService.socket.on("get_list_message", (data) {
      _fetchData();
    });
  }

  Future<void> _fetchData() async {
    await ref
        .read(listOfMessageControllerProvider.notifier)
        .getListOfMessage(chatUserDocId: widget.userId);
    setState(() {
      isLoading = false;
    });
  }

  String formatLastSeen(DateTime dateTime) {
    final now = DateTime.now();

    if (now.year == dateTime.year &&
        now.month == dateTime.month &&
        now.day == dateTime.day) {
      // Same day → show time
      return DateFormat('hh:mm a').format(dateTime);
    } else {
      // Different day → show date
      return DateFormat('dd-MM-yyyy').format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatList = ref.watch(listOfMessageControllerProvider);
    final chatUserDocId = ref.watch(chatUserDocIdProvider);
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : chatList.isEmpty
              ? Center(
                  child: SizedBox(
                    width: w * 0.5,
                    height: w * 0.5,
                    child: Lottie.asset(AnimationAssets.noDataFound),
                  ),
                )
              : ListView.builder(
                  itemCount: chatList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        leading: chatList[index].secondPersonAvatar!.isEmpty
                            ? CircleAvatar(
                                radius: 28,
                                backgroundColor: Colors.grey.shade300,
                                child: const Icon(
                                  Icons.person,
                                  size: 40,
                                ),
                              )
                            : CircleAvatar(
                                radius: 28,
                                backgroundImage: NetworkImage(
                                    chatList[index].secondPersonAvatar!),
                              ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              chatList[index].secondPersonName!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            chatList[index].unreadCount != null &&
                                    chatList[index].unreadCount! > 0
                                ? Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      chatList[index].unreadCount.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              chatList[index].lastMessage!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.black87),
                            ),
                            Text(
                              ' ${chatList[index].lastSentAt != null ? formatLastSeen(chatList[index].lastSentAt!) : "Recently"}',
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MessageListView(
                                personName: chatList[index].secondPersonName!,
                                sender: chatUserDocId!,
                                receiver: chatList[index].secondPersonId!,
                                avatar: chatList[index].secondPersonAvatar!,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
    );
  }
}
