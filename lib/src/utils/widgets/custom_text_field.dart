// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;
  final String hintText;
  final Widget? icon;
  final double? width;
  final int? minlines;
  final int? maxlines;
  final double left;
  final double right;
  final double? borderRadius;
  final TextInputType textInputType;
  final int? length;
  const CustomTextField(
      {super.key,
      required this.validator,
      required this.hintText,
      required this.controller,
      this.icon,
      this.minlines,
      this.maxlines,
      this.width,
      this.left = 22,
      this.right = 22,
      this.textInputType = TextInputType.text,
      this.length,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;

    return Container(
      width: width,
      padding: EdgeInsets.only(left: left, right: right, top: 18),
      child: TextFormField(
        maxLength: length,
        controller: controller,
        validator: validator,
        minLines: minlines,
        maxLines: maxlines,
        decoration: InputDecoration(
            prefixIcon: icon,
            hintText: hintText,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 15),
                borderSide: BorderSide(
                  color: color.secondary,
                ))),
      ),
    );
  }
}
