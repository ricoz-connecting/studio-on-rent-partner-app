import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class CustomCheckBox extends StatefulWidget {
  CustomCheckBox(
      {super.key,
      required this.handleCheckBox,
      required this.data,
      this.minimumsize = MainAxisSize.min,
      required this.value});
  VoidCallback handleCheckBox;
  String data;
  MainAxisSize minimumsize;
  bool value;
  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Container(
      margin: EdgeInsets.all(6),
      padding: EdgeInsets.only(left: 8, right: 20),
      decoration: BoxDecoration(
          border: Border.all(color: color.onSecondary),
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisSize: widget.minimumsize,
        children: [
          Checkbox(
              value: widget.value,
              onChanged: (val) {
                setState(() {
                  widget.value = val!;
                });
                widget.handleCheckBox();
              }),
          Text(widget.data)
        ],
      ),
    );
  }
}
