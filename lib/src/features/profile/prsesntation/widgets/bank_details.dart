import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_partner_app/src/commons/globals/agent_details.dart';
import 'package:studio_partner_app/src/commons/views/widgets/simple_app_bar.dart';
import 'package:studio_partner_app/src/features/profile/domain/entity/bank_entity.dart';
import 'package:studio_partner_app/src/features/profile/prsesntation/bloc/bank_details/bank_details_bloc.dart';
import 'package:studio_partner_app/src/features/profile/prsesntation/views/profile_page.dart';
import 'package:studio_partner_app/src/features/profile/prsesntation/widgets/add_bank_details.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_extension_methods.dart';

class BankDetails extends StatefulWidget {
  static const routePath = '/bank-details';
  const BankDetails({super.key});

  @override
  State<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<BankDetailsBloc>()
        .add(GetBankDetailsEvent(agentId: globalAgentId));
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: color.surface,
      appBar: SimpleAppBar(
        bgColor: color.secondary,
        title: "Bank Details",
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              child: Text(
                "Select or Add bank details :",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            BlocConsumer<BankDetailsBloc, BankDetailsState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is BankDetailsSuccessState) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.banks.length,
                      itemBuilder: (context, index) =>
                          BankTile(bankEntity: state.banks[index]),
                    ),
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
            GestureDetector(
              onTap: () {
                context.push(AddBankDetails.routePath);
              },
              child: InfoBoxes(
                child: Center(
                  child: Icon(Icons.add),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BankTile extends StatelessWidget {
  final BankEntity bankEntity;
  const BankTile({
    super.key,
    required this.bankEntity,
  });

  @override
  Widget build(BuildContext context) {
    return InfoBoxes(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.balance),
          SizedBox(
            width: 20,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(bankEntity.bankName),
              Text("A/c No. ${bankEntity.accountNo.toString().slice(-4)}"),
            ],
          )),
          Icon(Icons.verified_outlined)
        ],
      ),
    );
  }
}
