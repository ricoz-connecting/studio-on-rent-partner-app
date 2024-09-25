import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentListTileWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const PaymentListTileWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.currency_rupee,
                size: 18,
                color: Color(0xff63B178),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff63B178),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
