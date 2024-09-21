import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final Function(String)? onChanged;
  final String? hintText;
  final Widget? child;
  final bool? obscureText;
  const AuthTextField({
    this.obscureText = false,
    this.child,
    this.hintText,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText!,
      onChanged: onChanged,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 14,
        ),
        suffixIcon: child,
        filled: true,
        fillColor: Colors.grey.shade300,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
      ),
    );
  }
}
