import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class ProgressDialog extends StatelessWidget {
  final String status;

  const ProgressDialog({super.key, required this.status});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      backgroundColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.all(16.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const CircularProgressIndicator(
                color: AppColors.primaryBackgroundColor,
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Text(
                  status,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
