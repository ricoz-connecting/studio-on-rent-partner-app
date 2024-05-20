import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_partner_app/src/commons/views/widgets/simple_app_bar.dart';
import 'package:studio_partner_app/src/features/help/presentation/pages/help_page.dart';
import 'package:studio_partner_app/src/features/profile/views/profile_page.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_extension_methods.dart';

class BookingDetails extends StatefulWidget {
  static const routePath = '/booking-details';
  const BookingDetails({super.key});
  

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: color.surface,
      appBar: SimpleAppBar(
        bgColor: color.secondary,
        title: "ID:12345",
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              const InfoBoxes(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Kitchen Cleaners")],
                ),
              ),
              const InfoBoxes(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Booking Details"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("No. of Cleaners"), Text("4")],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Time:12:00 - 15:00"),
                        Text("Date : 03 Nov 2023")
                      ],
                    ),
                  ],
                ),
              ),
              const InfoBoxes(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Contact Details"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("+91 2345676543"), Text("Call Customer")],
                    )
                  ],
                ),
              ),
              InfoBoxes(
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("SubTotal"),
                        Text("XXX"),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("GST"),
                        Text("XXX"),
                      ],
                    ),
                    Divider(
                      color: color.surface,
                      height: 4,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Amount Paid"),
                        Text("XXX"),
                      ],
                    ),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Download Invoice",
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                ).addSpacingBetweenElements(10),
              ),
              GestureDetector(
                onTap: () {
                  context.push(HelpPage.routePath);
                },
                child: const InfoBoxes(
                  child: Row(
                    children: [
                      Icon(Icons.help),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(child: Text("Need Help?")),
                      Icon(Icons.arrow_forward_ios_outlined)
                    ],
                  ),
                ),
              )
            ],
          ).addSpacingBetweenElements(10),
        ),
      ),
    );
  }
}
