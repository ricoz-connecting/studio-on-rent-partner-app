import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/feature/auth/views/widgets/reusable_button.dart';
import 'package:studio_partner_app/src/feature/bookings/views/invoice.dart';
import 'package:studio_partner_app/src/feature/bookings/views/pdfVIewer.dart';
import 'package:studio_partner_app/src/feature/bookings/views/widgets/customContainer.dart';
import 'package:studio_partner_app/src/models/bookings.dart';

class StudioDetail extends StatefulWidget {
  final Booking booking;
  const StudioDetail({required this.booking, super.key});

  @override
  State<StudioDetail> createState() => _StudioDetailState();
}

class _StudioDetailState extends State<StudioDetail> {
  String? pdfPath;
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ID: ${widget.booking.orderId}',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    widget.booking.studioDetails.thumbnail,
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 15),
            CustomContainer(
              child: Row(
                children: [
                  Text(
                    'Studio Name',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF5D5D5D),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    widget.booking.studioDetails.studioName,
                    style: GoogleFonts.inter(color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            CustomContainer(
              child: Row(
                children: [
                  Text(
                    'Customer Name',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF5D5D5D),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    widget.booking.customerDetails.name,
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            CustomContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Booking Details',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF5D5D5D),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'Duration',
                        style:
                            GoogleFonts.inter(color: const Color(0xFF414141)),
                      ),
                      const Spacer(),
                      Text(
                        '${widget.booking.paymentDetails.duration.value} ${widget.booking.paymentDetails.duration.title}',
                        style: GoogleFonts.inter(color: Colors.black),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
            CustomContainer(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: w * 0.25,
                    child: Text(
                      'Address',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF5D5D5D),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      textAlign: TextAlign.end,
                      widget.booking.studioDetails.address,
                      style: GoogleFonts.inter(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            CustomContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact Details',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF5D5D5D),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        widget.booking.customerDetails.phone,
                        style:
                            GoogleFonts.inter(color: const Color(0xFF414141)),
                      ),
                      const Spacer(),
                      Text(
                        'Call Customer',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF6D52EF),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            CustomContainer(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Subtotal',
                        style: GoogleFonts.inter(
                          color: const Color(
                            0xFF444444,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "₹ ${widget.booking.paymentDetails.subTotalAmount}",
                        style: GoogleFonts.inter(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'GST',
                        style: GoogleFonts.inter(
                          color: const Color(
                            0xFF444444,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '₹ ${widget.booking.paymentDetails.taxAmount}',
                        style: GoogleFonts.inter(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Text(
                        'Total Amount (Paid)',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF5D5D5D),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '₹ ${widget.booking.paymentDetails.paidAmount}',
                        style: GoogleFonts.inter(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ReusableButton(
                    radius: 10,
                    label: 'Download Invoice',
                    onPressed: () async {
                      final path = await CreateInvoice.createInvoicePDF();
                      setState(() {
                        pdfPath = path;
                      });
                      context.mounted
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PDFViewerScreen(path: pdfPath!),
                              ),
                            )
                          : null;
                    },
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
            const CustomContainer(
              child: Row(
                children: [
                  Icon(Icons.help),
                  SizedBox(width: 10),
                  Text('Need Help?'),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
