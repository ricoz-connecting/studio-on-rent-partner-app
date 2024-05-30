import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/core/themes/theme.dart';
import 'package:studio_partner_app/src/features/chat/data/model/message_model.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel messageModel;

  const MessageBubble({
    Key? key,
    required this.messageModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment:
          !messageModel.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints: const BoxConstraints(
            maxWidth: 283,
          ),
          padding: const EdgeInsets.all(14),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          decoration: BoxDecoration(
            // color: color.surfaceVariant,
            color: !messageModel.isMe ? color.primary : color.surface,
            border: Border.all(
              color: !messageModel.isMe
                  ? Colors.transparent
                  : ColorAssets.blackFaded.withOpacity(0.25),
            ),
            borderRadius: BorderRadius.only(
              topRight:
                  !messageModel.isMe ? Radius.zero : const Radius.circular(15),
              topLeft:
                  !messageModel.isMe ? const Radius.circular(15) : Radius.zero,
              bottomLeft: const Radius.circular(15),
              bottomRight: const Radius.circular(15),
            ),
          ),
          child: RichText(
            text: TextSpan(
                text: messageModel.message,
                style: TextStyle(color: ColorAssets.black)),
          ),
        )
      ],
    );
  }
}
