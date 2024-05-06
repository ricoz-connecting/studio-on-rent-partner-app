import 'package:flutter/material.dart';

class CustomListTile extends StatefulWidget {
  const CustomListTile({super.key, required this.onTap});
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
              const Expanded(flex: 1, child: CircleAvatar()),
              const Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ID:12345",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("hello")
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    const Text("16:30"),
                    Container(
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color.primary,
                      ),
                      child: Center(
                          child: Text(
                        "2",
                        style: TextStyle(color: color.surface),
                      )),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
