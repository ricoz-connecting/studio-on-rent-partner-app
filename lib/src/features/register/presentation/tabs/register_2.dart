import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_text_field.dart';

// ignore: must_be_immutable
class Register2 extends StatelessWidget {
  Register2({super.key});
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomTextField(
                validator: (val) {
                  return null;
                },
                hintText: 'Enter business name (optional)',
                controller: controller,
                icon: const Icon(Icons.business)),
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 40),
              child: Text(
                'Enter your address',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            CustomTextField(
                validator: (val) {
                  return null;
                },
                hintText: 'Address Line 1',
                controller: controller,
                icon: const Icon(Icons.house)),
            CustomTextField(
                validator: (val) {
                  return null;
                },
                hintText: 'Address Line 1',
                controller: controller,
                icon: const Icon(Icons.house)),
            Row(
              children: [
                CustomTextField(
                    right: 10,
                    width: MediaQuery.of(context).size.width / 2,
                    validator: (validator) {
                      return null;
                    },
                    hintText: 'City',
                    controller: controller,
                    icon: Icon(Icons.house)),
                CustomTextField(
                    left: 10,
                    width: MediaQuery.of(context).size.width / 2.28,
                    validator: (validator) {
                      return null;
                    },
                    hintText: 'State',
                    controller: controller,
                    icon: Icon(Icons.house))
              ],
            ),
            CustomTextField(
                textInputType: TextInputType.number,
                length: 6,
                validator: (validator) {
                  return null;
                },
                hintText: 'Pincode',
                controller: controller,
                icon: Icon(Icons.house)),
            SizedBox(
              height: 60,
            )
          ],
        ),
      ),
    );
  }
}
