import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_partner_app/src/commons/views/widgets/simple_app_bar.dart';
import 'package:studio_partner_app/src/features/profile/views/profile_page.dart';
import 'package:studio_partner_app/src/features/profile/widgets/add_bank_details.dart';

class BankDetails extends StatefulWidget {
  static const routePath = '/bank-details';
  const BankDetails({super.key});

  @override
  State<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
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
            BankTile(),
            BankTile(),
            BankTile(),
            BankTile(),
            GestureDetector(
              onTap: () {
                context.push(AddBankDetails.routrPath);
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
  const BankTile({
    super.key,
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
              Text("Bank Of Baroda"),
              Text("A/c No. XXXXX1912"),
            ],
          )),
          Icon(Icons.verified_outlined)
        ],
      ),
    );
  }
}
