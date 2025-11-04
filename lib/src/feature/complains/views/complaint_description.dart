import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:studio_partner_app/src/feature/complains/controller/complaint_controller.dart';

class ComplaintDescription extends ConsumerStatefulWidget {
  final String complaintDocId;
  const ComplaintDescription({
    super.key,
    required this.complaintDocId,
  });

  @override
  ConsumerState<ComplaintDescription> createState() =>
      _ComplaintDescriptionState();
}

class _ComplaintDescriptionState extends ConsumerState<ComplaintDescription> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchComplaintDetails();
  }

  Future<void> fetchComplaintDetails() async {
    await ref
        .read(complaintControllerProvider.notifier)
        .getComplaintsDetails(widget.complaintDocId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(complaintControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          data.complaintId != null ? '# ${data.complaintId}' : 'Complaint',
          style: GoogleFonts.lato(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Subject',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(16),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(data.subject ?? "No Subject"),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Spacer(),
                        Text(
                          data.createdAt != null
                              ? DateFormat('dd-MM-yyyy hh:mm a')
                                  .format(data.createdAt!)
                              : "",
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Description',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      constraints: const BoxConstraints(
                        minHeight: 100,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(data.description ?? "No Description"),
                    ),
                    const SizedBox(height: 10),
                    (data.image != null && data.image != "")
                        ? Text(
                            'Images',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : Container(),
                    (data.image != null && data.image != "")
                        ? const SizedBox(height: 4)
                        : const SizedBox(),
                    (data.image != null && data.image != "")
                        ? Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(data.image!),
                                  fit: BoxFit.cover,
                                )),
                          )
                        : Container(),
                    const SizedBox(height: 10),
                    Text(
                      'Admins Reply',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      constraints: const BoxConstraints(
                        minHeight: 100,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(data.adminReply ?? "No reply yet."),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
