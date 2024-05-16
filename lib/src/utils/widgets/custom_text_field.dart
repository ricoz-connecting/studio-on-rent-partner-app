// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
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
  final Widget? suffix;
  final Function(String)? onchanged;
  const CustomTextField(
      {super.key,
      required this.validator,
      required this.hintText,
      required this.controller,
      this.onchanged,
      this.suffix,
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
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;

    return Container(
      width: widget.width,
      padding: EdgeInsets.only(left: widget.left, right: widget.right, top: 18),
      child: TextFormField(
        onChanged: widget.onchanged,
        maxLength: widget.length,
        controller: widget.controller,
        validator: widget.validator,
        minLines: widget.minlines,
        maxLines: widget.maxlines,
        keyboardType: widget.textInputType,
        decoration: InputDecoration(
          suffix: widget.suffix,
            prefixIcon: widget.icon,
            hintText: widget.hintText,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 15),
                borderSide: BorderSide(
                  color: color.secondary,
                ))),
      ),
    );
  }
}
