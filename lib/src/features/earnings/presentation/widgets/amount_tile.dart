// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:studio_partner_app/src/core/themes/theme.dart';
import 'package:studio_partner_app/src/features/earnings/domain/entity/payment_entity.dart';

class AmountTile extends StatefulWidget {
  const AmountTile({
    Key? key,
    required this.transactions,
  }) : super(key: key);
  final Transactions transactions;

  @override
  State<AmountTile> createState() => _AmountTileState();
}

class _AmountTileState extends State<AmountTile> {
  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
          color: color.secondary, borderRadius: BorderRadius.circular(15)),
      padding: EdgeInsets.only(left: 10, right: 8, top: 10, bottom: 10),
      margin: EdgeInsets.only(top: 8, bottom: 8),
      child: Stack(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.transactions.id.contains('pout')
                        ? "Taken Out"
                        : "Added",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(Intl()
                      .date(DateFormat.ABBR_MONTH_WEEKDAY_DAY)
                      .format(widget.transactions.created_at))
                ],
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Text(
                widget.transactions.id.contains('pout')
                    ? "-${widget.transactions.amount}"
                    : "+${widget.transactions.amount}",
                style: widget.transactions.id.contains('pout')
                    ? TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)
                    : TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
              ))
        ],
      ),
    );
  }
}
