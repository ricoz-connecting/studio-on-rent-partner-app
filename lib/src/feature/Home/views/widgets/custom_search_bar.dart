import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSearchBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final String label;
  const CustomSearchBar({
    required this.label,
    required this.context,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      title: SearchBar(
        padding: WidgetStateProperty.all(
          const EdgeInsets.only(
            left: 10,
          ),
        ),
        hintStyle: WidgetStateProperty.all(
          GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        hintText: label,
        leading: const Icon(
          Icons.search,
          size: 30,
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(MediaQuery.of(context).size.height * 0.1);
}
