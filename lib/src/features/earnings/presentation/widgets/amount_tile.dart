import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/core/themes/theme.dart';

class AmountTile extends StatefulWidget {
  const AmountTile({super.key});

  @override
  State<AmountTile> createState() => _AmountTileState();
}

class _AmountTileState extends State<AmountTile> {
  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
          color: color.secondary, borderRadius: BorderRadius.circular(15)),
      padding: EdgeInsets.only(left: 10, right: 8, top: 10, bottom: 10),
      margin: EdgeInsets.only(top: 8, bottom: 8),
      child: Stack(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ID:12345",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("TRANSFER TO XXXX34")
                ],
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Text(
                "+3000",
                style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ))
        ],
      ),
    );
  }
}
