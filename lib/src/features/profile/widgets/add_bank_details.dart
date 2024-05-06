import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/commons/views/widgets/simple_app_bar.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_extension_methods.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_text_button.dart';

class AddBankDetails extends StatefulWidget {
  static const routrPath = '/add-bank-details';
  const AddBankDetails({super.key});

  @override
  State<AddBankDetails> createState() => _AddBankDetailsState();
}

class _AddBankDetailsState extends State<AddBankDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: "Add Bank Details",
        centerTitle: false,
      ),
      body: Padding(
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
                decoration: InputDecoration(label: Text("Enter Account No."))),
            TextFormField(
                decoration: InputDecoration(label: Text("IFSC code"))),
            TextFormField(
                decoration:
                    InputDecoration(label: Text("Account Holder Name"))),
          ],
        ),
      ),
      bottomNavigationBar: Container(
          height: 60,
          margin: EdgeInsets.all(20),
          alignment: Alignment.bottomCenter,
          child: CustomTextButton(text: "Proceed", ontap: () {})),
    );
  }
}
