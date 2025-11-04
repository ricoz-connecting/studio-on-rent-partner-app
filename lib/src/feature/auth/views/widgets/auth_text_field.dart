// import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final Function(String)? onChanged;
  final String? hintText;
  final Widget? child;
  final bool? obscureText;

  const AuthTextField({
    super.key,
    this.onChanged,
    this.hintText,
    this.child,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText ?? false,
      onChanged: onChanged,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 14,
        ),
        suffixIcon: child,
        filled: true,
        fillColor: const Color(0xFFF4F6F9),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade500),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade500, width: 0.4),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade500, width: 0.4),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blue.shade400, width: 0.6),
        ),
      ),
    );
  }
}
