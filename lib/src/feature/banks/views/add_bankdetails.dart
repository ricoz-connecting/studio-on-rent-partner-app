import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/feature/auth/views/widgets/reusable_button.dart';
import 'package:studio_partner_app/src/feature/banks/controller/bank_controller.dart';
import 'package:studio_partner_app/src/feature/banks/controller/search_details.dart';
import 'package:studio_partner_app/src/models/bank_details_model.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class AddBankdetails extends ConsumerStatefulWidget {
  final Banks? bankDetails;
  const AddBankdetails({super.key, this.bankDetails});

  @override
  ConsumerState<AddBankdetails> createState() => _BankDetailssState();
}

class _BankDetailssState extends ConsumerState<AddBankdetails> {
  TextEditingController ifscController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController accountNoController = TextEditingController();
  TextEditingController accountHolderController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  @override
  void initState() {
    if (widget.bankDetails != null) {
      ifscController.text = widget.bankDetails!.ifscCode;
      branchController.text = widget.bankDetails!.bankName;
      accountNoController.text = widget.bankDetails!.accountNumber;
      accountHolderController.text = widget.bankDetails!.accountHolderName;
      bankNameController.text = widget.bankDetails!.bankName;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Bank Details',
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add New Bank Account:',
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            BankDetailsField(
              controller: ifscController,
              label: 'IFSC Code',
              onChanged: (value) async {
                if (value.length == 11) {
                  FocusScope.of(context).unfocus();
                  await ref
                      .read(bankDetailsProvider.notifier)
                      .fetchBankDetails(value);
                  final bankDetails = ref.watch(bankDetailsProvider);
                  setState(() {
                    branchController.text = bankDetails['BRANCH'] ?? '';
                    bankNameController.text = bankDetails['BANK'] ?? '';
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            BankDetailsField(
              enabled: false,
              controller: bankNameController,
              label: 'Bank Name',
            ),
            const SizedBox(height: 20),
            BankDetailsField(
              controller: branchController,
              enabled: false,
              label: 'Branch Name',
            ),
            BankDetailsField(
              controller: accountNoController,
              label: 'Enter Account No.',
            ),
            const SizedBox(height: 20),
            BankDetailsField(
              controller: accountHolderController,
              label: 'Account Holder’s Name',
            ),
            const Spacer(),
            ReusableButton(
              label: 'Proceed',
              onPressed: () {
                widget.bankDetails != null
                    ? ref
                        .read(bankControllerProvider.notifier)
                        .updateBankDetail(
                          context: context,
                          bankId: widget.bankDetails!.id,
                          bankName: bankNameController.text,
                          accountHolderName: accountHolderController.text,
                          accountNumber: accountNoController.text,
                          ifscCode: ifscController.text,
                        )
                    : ref.read(bankControllerProvider.notifier).addBankDetail(
                        context: context,
                        bankName: bankNameController.text,
                        accountHolderName: accountHolderController.text,
                        accountNumber: accountNoController.text,
                        ifscCode: ifscController.text,
                        primary: true);
              },
              radius: 8,
            )
          ],
        ),
      ),
    );
  }
}

class BankDetailsField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final bool enabled;
  final Function(String)? onChanged;
  const BankDetailsField(
      {super.key,
      required this.label,
      this.onChanged,
      this.controller,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enabled,
      controller: controller,
      onChanged: onChanged,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.lato(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.black,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.black),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.black),
        ),
      ),
    );
    ;
  }
}
