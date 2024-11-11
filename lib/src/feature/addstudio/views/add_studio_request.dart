import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/feature/addstudio/views/widgets/navigation_tab.dart';
import 'package:studio_partner_app/src/feature/addstudio/views/widgets/request_button.dart';

class AddStudioRequest extends StatelessWidget {
  const AddStudioRequest({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Add Studio Request',
          style: GoogleFonts.inter(fontWeight: FontWeight.w500),
        ),
      ),
      body: const CustomTabbar(),
      
    );
  }
}
