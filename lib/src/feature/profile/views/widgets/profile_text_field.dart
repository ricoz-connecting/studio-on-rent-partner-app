import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class ProfileTextfield extends StatefulWidget {
  final String? label;
  final String hintText;
  final IconData? prefixIcon;
  final TextEditingController controller;
  final int? maxLines;
  final bool enabled;
  const ProfileTextfield(
      {super.key,
      this.label,
      required this.hintText,
      this.prefixIcon,
      required this.controller,
      this.maxLines,
      this.enabled = true});

  @override
  State<ProfileTextfield> createState() => _ProfileTextfieldState();
}

class _ProfileTextfieldState extends State<ProfileTextfield> {
  String? _labelText;

  @override
  void initState() {
    super.initState();
    _labelText = widget.controller.text.isEmpty
        ? widget.hintText
        : widget.hintText.replaceFirst(RegExp(r'Enter\s+'), '');
    widget.controller.addListener(_updateLabel);
  }

  void _updateLabel() {
    setState(() {
      _labelText = widget.controller.text.isEmpty
          ? widget.hintText
          : widget.hintText.replaceFirst(RegExp(r'Enter\s+'), '');
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateLabel);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.label!,
              style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        TextField(
          controller: widget.controller,
          maxLines: widget.maxLines ?? 1,
          enabled: widget.enabled,
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon != null
                ? Icon(
                    widget.prefixIcon,
                    color: Colors.black54,
                  )
                : null,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 14,
            ),
            filled: true,
            fillColor: AppColors.textBackgroundColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.grey.shade400,
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
                width: 1.0,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.textBackgroundColor,
                width: 2.0,
              ),
            ),
            labelText: _labelText,
            labelStyle: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
            hintText: widget.hintText,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            hintStyle: TextStyle(color: Colors.grey.shade500),
          ),
        ),
      ],
    );
  }
}
