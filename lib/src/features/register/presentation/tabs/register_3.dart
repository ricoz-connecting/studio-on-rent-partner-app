import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_check_box.dart';

class Register3 extends StatelessWidget {
  const Register3({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    List<String> availableServices = [
      "Photography",
      "Dance",
      "Occasion",
      "On Demand"
    ];
    List<String> addOns = ["Trainers", "A.C.", "Cleaners", "Wifi"];
    List<String> services = [
      "Cleaning Services",
      "Photography Services",
      "Training Services",
      "Wifi"
    ];
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('Select services you offer'),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border: Border.all(color: color.onSecondary),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Available Studio Service’s',
                        style:
                            const TextStyle().copyWith(fontWeight: FontWeight.w500)),
                  ),
                  Wrap(
                    children: availableServices
                        .map((e) =>
                            CustomCheckBox(handleCheckBox: () {}, data: e))
                        .toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Add Ons',
                      style: const TextStyle().copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Wrap(
                    children: addOns
                        .map((e) =>
                            CustomCheckBox(handleCheckBox: () {}, data: e))
                        .toList(),
                  ),
                ],
              ),
            ),
            for (var i in services)
              CustomCheckBox(
                handleCheckBox: () {},
                data: i,
                minimumsize: MainAxisSize.max,
              )
          ],
        ),
      ),
    );
  }
}
