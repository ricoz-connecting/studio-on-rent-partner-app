import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:studio_partner_app/src/feature/complains/views/widgets/status_widget.dart';
import 'package:studio_partner_app/src/res/assets.dart';
import 'package:studio_partner_app/utils/router.dart';

import '../controller/previous_complaint_controller.dart';

class PreviousComplaint extends ConsumerStatefulWidget {
  const PreviousComplaint({super.key});

  @override
  ConsumerState<PreviousComplaint> createState() => _PreviousComplaintState();
}

class _PreviousComplaintState extends ConsumerState<PreviousComplaint> {
  @override
  Widget build(BuildContext context) {
    final previousComplaints = ref.watch(previousComplaintControllerProvider);
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Previous Complaint',
          style: GoogleFonts.lato(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: previousComplaints.isEmpty
          ? Center(
              child: SizedBox(
                width: w * 0.5,
                height: w * 0.5,
                child: Lottie.asset(AnimationAssets.noDataFound),
              ),
            )
          : ListView.builder(
              itemCount: previousComplaints.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    GoRouter.of(context).push(
                      StudioRoutes.complaintDescription,
                      extra: previousComplaints[index].id,
                    );
                  },
                  child: StatusWidget(
                    isoDate: previousComplaints[index].createdAt!,
                    status: previousComplaints[index].status!,
                    sno: (index + 1).toString(),
                    subject: previousComplaints[index].subject!,
                  ),
                );
              },
            ),
    );
  }
}
