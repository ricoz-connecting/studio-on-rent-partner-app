import 'package:flutter/material.dart';

class ReusableAuthTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool? obscureText;
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function()? onSuffixIconTap;
  final String? Function(String?)? validator;

  const ReusableAuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText,
    this.onChanged,
    this.suffixIcon,
    this.prefixIcon,
    this.onSuffixIconTap,
    this.validator,
  });

  @override
  ReusableAuthTextFieldState createState() => ReusableAuthTextFieldState();
}

class ReusableAuthTextFieldState extends State<ReusableAuthTextField> {
  String? errorMessage;

  void _validateInput(String value) {
    if (widget.validator != null) {
      setState(() {
        errorMessage = widget.validator!(value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: widget.controller,
        onChanged: (value) {
          widget.onChanged?.call(value);
          _validateInput(value);
        },
        obscureText: widget.obscureText ?? false,
        validator: widget.validator,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 14,
          ),
          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          hintText: widget.hintText,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon != null
              ? GestureDetector(
                  onTap: widget.onSuffixIconTap,
                  child: widget.suffixIcon,
                )
              : null,
          errorText: errorMessage,
        ),
      ),
    );
  }
}
