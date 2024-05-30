// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:studio_partner_app/src/features/home/domain/entity/chat_entity.dart';

class CustomListTile extends StatefulWidget {
  const CustomListTile({
    Key? key,
    required this.chatEntity,
    required this.onTap,
  }) : super(key: key);
  final ChatEntity chatEntity;
  final VoidCallback onTap;

  @override
  State<StatefulWidget> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: color.tertiary, offset: Offset(2, 3), blurRadius: 10)
          ], color: color.secondary, borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: CircleAvatar(
                    backgroundImage: MemoryImage(widget.chatEntity.photoUrl),
                  )),
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.chatEntity.name,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    // Text("hello")
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text(Intl()
                        .date(DateFormat.HOUR24_MINUTE)
                        .format(widget.chatEntity.time)),
                    // Container(
                    //   width: 50,
                    //   decoration: BoxDecoration(
                    //     shape: BoxShape.circle,
                    //     color: color.primary,
                    //   ),
                    //   child: Center(
                    //       child: Text(
                    //     '',
                    //     style: TextStyle(color: color.surface),
                    //   )),
                    // )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
