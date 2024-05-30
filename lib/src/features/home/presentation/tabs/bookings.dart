import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:studio_partner_app/src/commons/params/update_params.dart';
import 'package:studio_partner_app/src/core/themes/theme.dart';
import 'package:studio_partner_app/src/features/chat/presentation/pages/chat_page.dart';
import 'package:studio_partner_app/src/features/home/domain/entity/schedule_entity.dart';
import 'package:studio_partner_app/src/features/home/presentation/bloc/schedule_bloc/schedules_bloc.dart';
import 'package:studio_partner_app/src/features/home/presentation/widgets/booking_details.dart';
import 'package:studio_partner_app/src/features/stores/presentation/pages/studio_page.dart';
import 'package:studio_partner_app/src/res/strings.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_extension_methods.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_text_button.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key, required this.socket});
  final Socket socket;
  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  List<String> categories = ['Active', 'New Request', 'Delivered'];
  int selectedIndex = 1;
  PageController controller = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return BlocBuilder<SchedulesBloc, SchedulesState>(
      builder: (context, state) {
        if (state is ScheduleSuccessState) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10, top: 10),
                padding: const EdgeInsets.only(bottom: 10),
                alignment: Alignment.topCenter,
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) => Container(
                          height: 29,
                          margin: EdgeInsets.only(left: index == 0 ? 20 : 15),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 17, vertical: 6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: selectedIndex == index
                                    ? color.primary
                                    : color.onSecondary,
                                width: selectedIndex == index ? 3 : 1,
                              )),
                          child: Center(
                            child: Text(
                              categories[index],
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: selectedIndex == index
                                    ? color.primary
                                    : color.onSecondary,
                              ),
                            ),
                          ),
                        ).onTap(() {
                          setState(() {
                            controller.animateToPage(index,
                                duration: const Duration(milliseconds: 100),
                                curve: Curves.bounceIn);
                            selectedIndex = index;
                          });
                        })),
              ),
              Expanded(
                child: PageView(
                  controller: controller,
                  onPageChanged: (val) {
                    log(val.toString());
                    setState(() {
                      selectedIndex = val;
                    });
                  },
                  children: [
                    RefreshIndicator(
                      onRefresh: () async {},
                      child: ListView.builder(
                        itemCount: state.schedules.where((e) {
                          return e.status == 'accepted';
                        }).length,
                        itemBuilder: (context, index) {
                          final accepted = state.schedules.where((e) {
                            return e.status == 'accepted';
                          }).toList();
                          return NewRequests(scheduleEntity: accepted[index]);
                        },
                      ),
                    ),

                    // SingleChildScrollView(
                    //     child: Column(
                    //         children: state.schedules
                    //             .map((E) => E.status == 'accepted'
                    //                 ? NewRequests(
                    //                     scheduleEntity: E,
                    //                     socket: widget.socket,
                    //                   )
                    //                 : SizedBox())
                    //             .toList())),
                    RefreshIndicator(
                      onRefresh: () async {},
                      child: ListView.builder(
                        itemCount: state.schedules.where((e) {
                          return e.status == 'pending';
                        }).length,
                        itemBuilder: (context, index) {
                          final accepted = state.schedules.where((e) {
                            return e.status == 'pending';
                          }).toList();
                          return NewRequests(scheduleEntity: accepted[index]);
                        },
                      ),
                    ),
                    RefreshIndicator(
                      onRefresh: () async {},
                      child: ListView.builder(
                        itemCount: state.schedules.where((e) {
                          return e.status == 'delivered';
                        }).length,
                        itemBuilder: (context, index) {
                          final accepted = state.schedules.where((e) {
                            return e.status == 'delivered';
                          }).toList();
                          return NewRequests(scheduleEntity: accepted[index]);
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        } else if (state is ScheduleLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}

// class BookingInformation extends StatelessWidget {
//   const BookingInformation({super.key});

//   @override
//   Widget build(BuildContext context) {
//     ColorScheme color = Theme.of(context).colorScheme;
//     return Container(
//       decoration: BoxDecoration(
//           color: color.secondary,
//           border: Border(top: BorderSide(color: color.onSurface))),
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text("ID:1234"),
//               RichText(
//                   text: TextSpan(
//                       text: "View Details",
//                       style: const TextStyle().copyWith(color: color.primary),
//                       recognizer: TapGestureRecognizer()
//                         ..onTap = () {
//                           context.push(BookingDetails.routePath);
//                         }))
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               RichText(
//                   text: TextSpan(
//                       text: "Studio Service",
//                       style: const TextStyle().copyWith(color: color.onSurface),
//                       children: [
//                     TextSpan(
//                         text: "(19/30)",
//                         style:
//                             const TextStyle().copyWith(color: color.primary)),
//                   ])),
//               RichText(
//                   text: TextSpan(
//                       text: "New\n",
//                       style: const TextStyle()
//                           .copyWith(color: color.onSurface, fontSize: 10),
//                       children: [
//                     TextSpan(
//                         text: "Lunch 04/11/2023",
//                         style:
//                             const TextStyle().copyWith(color: color.primary)),
//                   ])),
//             ],
//           ),
//           Divider(
//             color: color.surface,
//             thickness: 1,
//           ),
//           const Align(
//             alignment: Alignment.centerLeft,
//             child: Text("Next Customer Details"),
//           ),
//           const Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [Text("No. of People"), Text("100")],
//           ),
//           Divider(
//             color: color.surface,
//             thickness: 3,
//           ),
//           const Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 flex: 2,
//                 child: Text("Address"),
//               ),
//               Expanded(child: Text("123, XYZ Apt. New Delhi,Delhi, 123456"))
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10.0),
//             child: CustomTextButton(
//               text: "Chat with Customer",
//               ontap: () {},
//               borderRadius: 10,
//             ),
//           )
//         ],
//       ).addSpacingBetweenElements(10),
//     );
//   }
// }

class NewRequests extends StatelessWidget {
  const NewRequests({
    super.key,
    required this.scheduleEntity,
    this.socket,
  });
  final ScheduleEntity scheduleEntity;
  final Socket? socket;

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
          color: color.secondary,
          border: Border(top: BorderSide(color: color.onSurface))),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("ID:${scheduleEntity.id}"),
              RichText(
                  text: TextSpan(
                      text:
                          "${Intl().date(DateFormat.YEAR_MONTH_DAY).format(scheduleEntity.date)} ${scheduleEntity.time}",
                      style: const TextStyle().copyWith(color: color.primary),
                      recognizer: TapGestureRecognizer()..onTap = () {}))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                  text: TextSpan(
                text: "Booking Type",
                style: const TextStyle().copyWith(
                    color: color.onSurface, fontWeight: FontWeight.w400),
              )),
              RichText(
                  text: TextSpan(
                text: "Studio Service",
                style: const TextStyle()
                    .copyWith(color: color.onSurface, fontSize: 16),
              )),
            ],
          ),
          Divider(
            color: color.surface,
            thickness: 1,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text("Studio Details"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Store Details"),
              GestureDetector(
                onTap: () {
                  context.push(BookingView.routePath,
                      extra: {"id": scheduleEntity.studioId});
                },
                child: Text(
                  "View",
                  style: const TextStyle().copyWith(color: color.primary),
                ),
              )
            ],
          ),
          Divider(
            color: color.surface,
            thickness: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text("Customer Details"),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(scheduleEntity.userName),
                  Text(scheduleEntity.userEmail),
                  Text(scheduleEntity.usernumber)
                ],
              ))
            ],
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: scheduleEntity.status == 'pending'
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          margin: const EdgeInsets.only(right: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: color.error)),
                          child: Text(
                            "Reject",
                            style: TextStyle(color: color.error),
                          ),
                        ).onTap(() {
                          context.read<SchedulesBloc>().add(UpdateScheduleEvent(
                              params: UpdateParams(
                                  scheduleId: scheduleEntity.id,
                                  status: ScheduleStatus.rejected)));
                        }),
                        Expanded(
                          flex: 2,
                          child: CustomTextButton(
                            bgColor: const Color.fromARGB(255, 83, 216, 88),
                            text: "Accept",
                            ontap: () {
                              context.read<SchedulesBloc>().add(
                                  UpdateScheduleEvent(
                                      params: UpdateParams(
                                          scheduleId: scheduleEntity.id,
                                          status: ScheduleStatus.accepted)));
                            },
                            borderRadius: 10,
                          ),
                        ),
                      ],
                    )
                  : scheduleEntity.status == "delivered"
                      ? CustomTextButton(
                          text: 'DELIVERED',
                          ontap: () {},
                          bgColor: ColorAssets.green,
                        )
                      : CustomTextButton(
                          borderRadius: 15,
                          text: 'Chat with Customer',
                          ontap: () {
                            context.push(ChatPage.routePath, extra: {
                              'socket': socket!,
                              'uuid': scheduleEntity.userId
                            });
                          }))
        ],
      ).addSpacingBetweenElements(10),
    );
  }
}
