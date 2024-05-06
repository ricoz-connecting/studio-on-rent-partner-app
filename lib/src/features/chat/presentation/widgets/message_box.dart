import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/core/themes/theme.dart';

class MessageBubble extends StatelessWidget {
  final bool isMe;
  final String message;
  final String searchString;

  const MessageBubble(
      {Key? key,
      required this.isMe,
      required this.message,
      required this.searchString})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints: const BoxConstraints(
            maxWidth: 283,
          ),
          padding: const EdgeInsets.all(14),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          decoration: BoxDecoration(
            // color: color.surfaceVariant,
            color: isMe ? color.primary : color.surface,
            border: Border.all(
              color: isMe
                  ? Colors.transparent
                  : ColorAssets.blackFaded.withOpacity(0.25),
            ),
            borderRadius: BorderRadius.only(
              topRight: isMe ? Radius.zero : const Radius.circular(15),
              topLeft: isMe ? const Radius.circular(15) : Radius.zero,
              bottomLeft: const Radius.circular(15),
              bottomRight: const Radius.circular(15),
            ),
          ),
          child: RichText(
            text: TextSpan(
                text: message, style: TextStyle(color: ColorAssets.black)),
          ),
        )
      ],
    );
  }
}
