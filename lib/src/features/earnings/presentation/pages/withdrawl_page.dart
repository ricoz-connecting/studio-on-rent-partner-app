import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' as fp;
import 'package:go_router/go_router.dart';
import 'package:studio_partner_app/src/commons/globals/agent_details.dart';
import 'package:studio_partner_app/src/commons/params/bank_params.dart';
import 'package:studio_partner_app/src/commons/views/widgets/simple_app_bar.dart';
import 'package:studio_partner_app/src/features/earnings/presentation/bloc/withdraw_bloc/withdraw_bloc.dart';
import 'package:studio_partner_app/src/features/profile/domain/entity/bank_entity.dart';
import 'package:studio_partner_app/src/features/profile/prsesntation/bloc/bank_details/bank_details_bloc.dart';
import 'package:studio_partner_app/src/features/profile/prsesntation/widgets/add_bank_details.dart';
import 'package:studio_partner_app/src/features/profile/prsesntation/widgets/bank_details.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_extension_methods.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_text_button.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_text_field.dart';

class WithdrawlPage extends StatefulWidget {
  const WithdrawlPage({super.key});
  static const routePath = '/withdrawl-page';
  @override
  State<WithdrawlPage> createState() => _WithdrawlPageState();
}

class _WithdrawlPageState extends State<WithdrawlPage> {
  late TextEditingController amountController;
  BankEntity? selectedBank;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<BankDetailsBloc>()
        .add(GetBankDetailsEvent(agentId: globalAgentId));
    amountController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    amountController.dispose();
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: 'Withdrawl',
      ),
      body: BlocConsumer<WithdrawBloc, WithdrawState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is WithdrawlSuccessState) {
            context.pop();
          }
        },
        builder: (context, state) {
          log(state.toString());
          if (state is WithdrawlLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: BlocBuilder<BankDetailsBloc, BankDetailsState>(
              builder: (context, state) {
                if (state is BankDetailsSuccessState) {
                  if (state.banks.isEmpty) {
                    context.push(AddBankDetails.routePath);
                  }
                  return Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                            textInputType: TextInputType.number,
                            validator: (val) {
                              late double amounts;
                              if (val!.isNotEmpty) {
                                final amount = val.toDoubleEither(() => false);
                                amount.fold((onLeft) => 'INVALID NUMBER',
                                    (onRight) => amounts = onRight);
                                if (amounts < 100) {
                                  return 'AMOUNT SHOULD BE GREATER THAN 100 Rs';
                                }
                                if (amounts >
                                    globalAgentModel!.amount.toDouble()) {
                                  return "AMOUNT SHOULD BE LESS THAN OR EQUAL TO YOUR EARNINGS";
                                }
                                return null;
                              }
                              return 'AMOUNT CANNOT BE EMPTY';
                            },
                            hintText: 'Amount to Be Withdrawn',
                            controller: amountController),
                        Container(
                          margin: EdgeInsets.all(18),
                          alignment: Alignment.centerLeft,
                          child: Text("Choose Account"),
                        ),
                        for (var i in state.banks)
                          Container(
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: selectedBank != null
                                          ? i.accountNo ==
                                                  selectedBank!.accountNo
                                              ? Border.all(color: Colors.blue)
                                              : null
                                          : null),
                                  child: BankTile(bankEntity: i))
                              .onTap(() {
                            setState(() {
                              selectedBank = i;
                            });
                          }),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: CustomTextButton(
                            ontap: () {
                              if (_formKey.currentState!.validate() &&
                                  selectedBank != null) {
                                final amount_either = amountController.text
                                    .trim()
                                    .toDoubleEither(() {});
                                amount_either.fold((l) {}, (r) {
                                  context.read<WithdrawBloc>().add(
                                      WithdrawAmountEvent(
                                          bank: PaymentParams(
                                              accountNo:
                                                  selectedBank!.accountNo,
                                              agentId: globalAgentId,
                                              amount: r)));
                                });
                              }
                            },
                            text: 'Withdraw',
                          ),
                        )
                      ],
                    ),
                  );
                }
                return SizedBox();
              },
            ),
          );
        },
      ),
    );
  }
}
