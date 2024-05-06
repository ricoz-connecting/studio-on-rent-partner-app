import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/core/themes/theme.dart';
import 'package:studio_partner_app/src/features/earnings/presentation/widgets/amount_tile.dart';
import 'package:studio_partner_app/src/features/earnings/presentation/widgets/money_box.dart';

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
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 150,
                child: DropdownButtonFormField(
                  hint: Text("today"),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: color.secondary))),
                  onChanged: (val) {},
                  items: [
                    DropdownMenuItem(
                      child: Text("Today1"),
                      value: "today1",
                    ),
                    DropdownMenuItem(
                      child: Text("Today2"),
                      value: "today2",
                    ),
                    DropdownMenuItem(
                      child: Text("Today3"),
                      value: "today4",
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(
                top: 15,
                bottom: 15,
              ),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(217, 209, 252, 1),
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
                        "Rs. 5000",
                        style: TextStyle(
                            color: color.primary.withGreen(22).withBlue(255),
                            fontSize: 25,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "Today's Earning",
                        style: TextStyle(
                            color: ColorAssets.lightGray, fontSize: 14),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Rs. 5000",
                        style: TextStyle(
                            color: color.primary.withGreen(22).withBlue(255),
                            fontSize: 25,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "Today's Earning",
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
                MoneyBox(),
                MoneyBox(),
                MoneyBox(),
                MoneyBox(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Transaction History",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            AmountTile(),
            AmountTile(),
            AmountTile(),
            AmountTile(),
          ],
        ),
      ),
    );
  }
}
