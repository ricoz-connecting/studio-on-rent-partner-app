import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/core/themes/theme.dart';

class MoneyBox extends StatefulWidget {
  const MoneyBox({super.key});

  @override
  State<MoneyBox> createState() => _MoneyBoxState();
}

class _MoneyBoxState extends State<MoneyBox> {
  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.only(left: 20, top: 20, right: 10),
      // margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),
      height: 110,
      width: 150,
      // constraints: BoxConstraints(maxWidth: 100, minWidth: 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color.fromRGBO(227, 221, 255, 1),
        border: Border(left: BorderSide(color: color.primary, width: 7)),
        // boxShadow: [
        //   BoxShadow(
        //       color: color.primary, offset: Offset(-4, 0), spreadRadius: 0)
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "2",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 30,
                color: ColorAssets.black),
          ),
          Text(
            "data",
            style: TextStyle(color: ColorAssets.lightGray),
          )
        ],
      ),
    );
  }
}
