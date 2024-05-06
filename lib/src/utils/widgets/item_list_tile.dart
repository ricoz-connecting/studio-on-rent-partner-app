import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/res/assets.dart';

class ItemListTile extends StatefulWidget {
  const ItemListTile({super.key});

  @override
  State<ItemListTile> createState() => _ItemListTileState();
}

class _ItemListTileState extends State<ItemListTile> {
  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
          color: color.secondary,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: color.tertiary, offset: Offset(2, 3), blurRadius: 10)
          ]),
      padding: EdgeInsets.only(
        left: 15,
      ),
      margin: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dance Studio",
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                Text(
                  "₹ 50000/- Per Month",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text("No. of Days 123, XYZ Apt., New Delhi, Pin - 123456")
              ],
            ),
          ),
          Container(
            height: 100,
            width: 100,
            // padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    ImageAssets.studio,
                  ),
                  fit: BoxFit.cover),
              color: color.surface,
              borderRadius: BorderRadius.circular(10),
            ),
          )
        ],
      ),
    );
  }
}
