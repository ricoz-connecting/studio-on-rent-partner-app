import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_partner_app/src/commons/globals/agent_details.dart';
import 'package:studio_partner_app/src/commons/views/widgets/custom_list_tile.dart';
import 'package:studio_partner_app/src/core/themes/theme.dart';
import 'package:studio_partner_app/src/features/earnings/presentation/bloc/earning_bloc/earning_bloc.dart';
import 'package:studio_partner_app/src/features/earnings/presentation/bloc/review_bloc/review_bloc.dart';
import 'package:studio_partner_app/src/features/earnings/presentation/pages/withdrawl_page.dart';
import 'package:studio_partner_app/src/features/earnings/presentation/widgets/amount_tile.dart';
import 'package:studio_partner_app/src/features/earnings/presentation/widgets/money_box.dart';
import 'package:studio_partner_app/src/features/home/presentation/bloc/schedule_bloc/schedules_bloc.dart';
import 'package:studio_partner_app/src/features/home/presentation/bloc/store_bloc/store_bloc.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_text_button.dart';

class EarningPages extends StatefulWidget {
  final VoidCallback callback;
  const EarningPages({super.key, required this.callback});

  @override
  State<EarningPages> createState() => _EarningPagesState();
}

class _EarningPagesState extends State<EarningPages> {
  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: RefreshIndicator(
        onRefresh: () async {
          context
              .read<SchedulesBloc>()
              .add(GetScheduleEvent(agentId: globalAgentId));
          context.read<StoreBloc>().add(GetStoreEvent(agentId: globalAgentId));
          context
              .read<EarningBloc>()
              .add(GetEarningEvent(agentId: globalAgentId));
          context
              .read<ReviewBloc>()
              .add(GetReviewEvent(agentId: globalAgentId));
        },
        child: SingleChildScrollView(
          child: BlocConsumer<EarningBloc, EarningState>(
            listener: (context, state) {
              //
            },
            builder: (context, state) {
              if (state is EarningSuccessState) {
                return Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: SizedBox(
                        width: 150,
                        child: DropdownButtonFormField(
                          hint: const Text("today"),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: color.secondary))),
                          onChanged: (val) {},
                          items: const [
                            DropdownMenuItem(
                              value: "today1",
                              child: Text("Today1"),
                            ),
                            DropdownMenuItem(
                              value: "today2",
                              child: Text("Today2"),
                            ),
                            DropdownMenuItem(
                              value: "today4",
                              child: Text("Today3"),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.only(
                        top: 15,
                        bottom: 15,
                      ),
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(217, 209, 252, 1),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                color: color.onSurfaceVariant.withOpacity(0.1),
                                blurRadius: 20)
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                state.earnings.todaysEarning.toString(),
                                style: TextStyle(
                                    color: color.primary
                                        .withGreen(22)
                                        .withBlue(255),
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700),
                              ),
                              const Text(
                                "Today's Earning",
                                style: TextStyle(
                                    color: ColorAssets.lightGray, fontSize: 14),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                globalAgentModel!.amount.toString(),
                                style: TextStyle(
                                    color: color.primary
                                        .withGreen(22)
                                        .withBlue(255),
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700),
                              ),
                              const Text(
                                "Total Earning",
                                style: TextStyle(
                                    color: ColorAssets.lightGray, fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Wrap(
                      spacing: 50,
                      runSpacing: 20,
                      children: [
                        MoneyBox(
                          nums: state.earnings.allSchdules,
                          text: "All Schedules",
                        ),
                        MoneyBox(
                            nums: state.earnings.acceptedSchedules,
                            text: "Accepted Schedules"),
                        MoneyBox(
                            nums: state.earnings.pendingSchedules,
                            text: "Pending Schedules"),
                        MoneyBox(
                            nums: state.earnings.rejectedSchedules,
                            text: "Rejected Schedules"),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: RichText(
                          text: TextSpan(
                              text: "Click Here! ",
                              style: TextStyle(
                                  color: color.primary,
                                  fontSize: 16,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = widget.callback,
                              children: [
                            TextSpan(
                              text: "to View customer reviews",
                              style: TextStyle(
                                  color: color.onPrimaryContainer,
                                  decoration: TextDecoration.none),
                            )
                          ])),
                    ),
                    CustomTextButton(
                      text: "Withdraw",
                      ontap: () {
                        context.push(WithdrawlPage.routePath);
                      },
                      borderRadius: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Transaction History",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ),
                    for (var i in state.earnings.transaction)
                      AmountTile(transactions: i)
                  ],
                );
              } else if (state is EarningLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return const Center(
                  child: Text("NO DATA TO SHOW"),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
