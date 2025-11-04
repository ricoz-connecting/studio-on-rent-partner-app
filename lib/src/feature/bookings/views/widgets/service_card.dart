import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/commons/views/providers/authprovider.dart';
import 'package:studio_partner_app/src/feature/bookings/views/studio_details.dart';
import 'package:studio_partner_app/src/feature/chat_screen/controller/chat_user_id.dart';
import 'package:studio_partner_app/src/feature/chat_screen/views/message_screen.dart';
import 'package:studio_partner_app/src/models/bookings.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class ServiceCard extends StatelessWidget {
  final Booking? booking;
  final bool isComingFromActive;

  const ServiceCard({
    super.key,
    this.booking,
    required this.isComingFromActive,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFF4F6F9),
      elevation: 1,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(booking!.partnerDetails.avatar),
                  radius: 24,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking!.customerDetails.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'ID : ${booking!.orderId}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return StudioDetail(
                        booking: booking!,
                      );
                    }));
                  },
                  child: Text(
                    'View Details',
                    style: GoogleFonts.poppins(
                      color: AppColors.primaryBackgroundColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            const Divider(height: 5),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  booking!.studioDetails.thumbnail,
                  width: 100,
                  height: 100,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        booking!.studioDetails.studioName,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        textAlign: TextAlign.start,
                        booking!.studioDetails.category,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        textAlign: TextAlign.start,
                        booking!.studioDetails.address,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Booking Details',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Booking Starts on: ',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              booking?.bookingDetails.startTime ?? '',
                              style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Booking Ends on: ',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              booking?.bookingDetails.endTime ?? '',
                              style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Duration: ',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "${booking!.paymentDetails.duration?.value} ${booking!.paymentDetails.duration?.title}",
                              style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ]),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Consumer(builder: (context, ref, child) {
              return ElevatedButton(
                // onPressed: () async {
                //   final user = ref.read(currentUserProvider);
                //   final id = ref.watch(chatUserDocIdProvider);
                //   if (id == null) {
                //     ref
                //         .read(chatUserControllerProvider.notifier)
                //         .updateChatUser(
                //           avatar: user?.avatar ?? '',
                //           email: user?.email ?? '',
                //           name: user?.name ?? '',
                //           phone: user?.phone ?? '',
                //           context: context,
                //         );
                //   }
                //   final result = await ref
                //       .read(chatUserControllerProvider.notifier)
                //       .createConnection(
                //         avatar: '',
                //         email: booking!.customerDetails.email,
                //         name: booking!.customerDetails.name,
                //         phone: booking!.customerDetails.phone,
                //         context: context,
                //       );

                //   print("####################################################");
                //   result.fold(
                //     (failure) {
                //       print('Failure: ${failure.message}');
                //     },
                //     (connectionId) {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => MessageListView(
                //             personName: booking!.customerDetails.name,
                //             sender: id!,
                //             receiver: connectionId,
                //             avatar: '',
                //           ),
                //         ),
                //       );
                //       print('Connection with: $id');
                //       print('Connection Created: $connectionId');
                //     },
                //   );
                onPressed: () async {
                  final user = ref.read(currentUserProvider);
                  var id = ref.watch(chatUserDocIdProvider);

                  if (id == null) {
                    await ref
                        .read(chatUserControllerProvider.notifier)
                        .updateChatUser(
                          avatar: user?.avatar ?? '',
                          email: user?.email ?? '',
                          name: user?.name ?? '',
                          phone: user?.phone ?? '',
                          context: context,
                        );

                    // Re-read the updated ID after updating chat user
                    id = ref.watch(chatUserDocIdProvider);
                  }

                  if (id == null) {
                    print("Error: Chat User ID is still null after updating.");
                    return;
                  }

                  final result = await ref
                      .read(chatUserControllerProvider.notifier)
                      .createConnection(
                        avatar: '',
                        email: booking!.customerDetails.email,
                        name: booking!.customerDetails.name,
                        phone: booking!.customerDetails.phone,
                        context: context,
                      );

                  print("####################################################");
                  result.fold(
                    (failure) {
                      print('Failure: ${failure.message}');
                    },
                    (connectionId) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MessageListView(
                            personName: booking!.customerDetails.name,
                            sender: id!,
                            receiver: connectionId,
                            avatar: '',
                          ),
                        ),
                      );
                      print('Connection with: $id');
                      print('Connection Created: $connectionId');
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: (AppColors.primaryBackgroundColor),
                  minimumSize: const Size(double.infinity, 36),
                  shadowColor: Colors.black.withOpacity(0.2),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.chat_bubble_outline,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Chat with Customer',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
