import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/feature/complains/views/widgets/status_widget.dart';
import 'package:studio_partner_app/utils/router.dart';

class PreviousComplaint extends StatelessWidget {
  PreviousComplaint({super.key});

  final List<Widget> statusWidget = [
    const StatusWidget(sno: '0', status: 'Pending'),
    const StatusWidget(sno: '1', status: 'Unsolved'),
    const StatusWidget(sno: '2', status: 'Solved'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Previous Complaint',
          style: GoogleFonts.lato(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                GoRouter.of(context).push(StudioRoutes.complaintDescription,
                    extra: index.toString());
              },
              child: statusWidget[index]);
        },
      ),
    );
  }
}
