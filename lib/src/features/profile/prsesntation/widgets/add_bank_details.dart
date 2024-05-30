import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_partner_app/src/commons/globals/agent_details.dart';
import 'package:studio_partner_app/src/commons/params/bank_params.dart';
import 'package:studio_partner_app/src/commons/views/widgets/simple_app_bar.dart';
import 'package:studio_partner_app/src/features/profile/prsesntation/bloc/bank_details/bank_details_bloc.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_extension_methods.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_text_button.dart';

class AddBankDetails extends StatefulWidget {
  static const routePath = '/add-bank-details';
  const AddBankDetails({super.key});

  @override
  State<AddBankDetails> createState() => _AddBankDetailsState();
}

class _AddBankDetailsState extends State<AddBankDetails> {
  @override
  final TextEditingController accountNoEditingController =
      TextEditingController();
  final TextEditingController ifscCodeditingController =
      TextEditingController();
  final TextEditingController accountHolderEditingController =
      TextEditingController();
  final TextEditingController bankNameEditingController =
      TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: "Add Bank Details",
        centerTitle: false,
      ),
      body: BlocListener<BankDetailsBloc, BankDetailsState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is BankDetailsSuccessState) {
            context.pop();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Add New Bank Account :",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              TextFormField(
                  controller: accountNoEditingController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Account No. cannot be Empty';
                    }
                    return null;
                  },
                  decoration:
                      InputDecoration(label: Text("Enter Account No."))),
              TextFormField(
                  maxLength: 11,
                  controller: ifscCodeditingController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'IFSC code cannot be Empty';
                    }
                    return null;
                  },
                  decoration: InputDecoration(label: Text("IFSC code"))),
              TextFormField(
                  controller: accountHolderEditingController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Account holder name cannot be Empty';
                    }
                    return null;
                  },
                  decoration:
                      InputDecoration(label: Text("Account Holder Name"))),
              TextFormField(
                  controller: bankNameEditingController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Bank Name cannot be Empty';
                    }
                    return null;
                  },
                  decoration: InputDecoration(label: Text("Bank Name"))),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
          height: 60,
          margin: EdgeInsets.all(20),
          alignment: Alignment.bottomCenter,
          child: CustomTextButton(
              text: "Proceed",
              ontap: () {
                context.read<BankDetailsBloc>().add(AddBankDetailsEvent(
                    bankParams: BankParams(
                        accountNo: accountNoEditingController.text.trim(),
                        agentId: globalAgentId,
                        ifscCode: ifscCodeditingController.text.trim(),
                        bankName: bankNameEditingController.text.trim(),
                        holderName:
                            accountHolderEditingController.text.trim())));
              })),
    );
  }
}
