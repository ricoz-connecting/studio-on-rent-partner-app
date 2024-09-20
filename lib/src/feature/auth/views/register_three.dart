import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/feature/auth/views/register_four.dart';
import 'package:studio_partner_app/src/feature/auth/views/widgets/custom_checkbox.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class RegisterThree extends StatefulWidget {
  const RegisterThree({super.key});

  @override
  State<RegisterThree> createState() => _RegisterThreeState();
}

class _RegisterThreeState extends State<RegisterThree> {
  bool isPhotographyChecked = true;
  bool isDanceChecked = false;
  bool isOccasionChecked = true;
  bool isOnDemandChecked = false;
  bool isTrainerChecked = true;
  bool isACChecked = false;
  bool isCleanersChecked = false;
  bool isWiFiChecked = true;
  bool isCleaningServicesChecked = false;
  bool isTrainingServicesChecked = false;
  bool isPhotographyServicesChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register',
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: Column(
          children: [
            const Text('Select services you offer'),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Available Studio Services',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: [
                      buildCustomCheckbox("Photography", isPhotographyChecked,
                          (value) {
                        setState(() {
                          isPhotographyChecked = value!;
                        });
                      }, true),
                      buildCustomCheckbox("Dance", isDanceChecked, (value) {
                        setState(() {
                          isDanceChecked = value!;
                        });
                      }, true),
                      buildCustomCheckbox("Occasion", isOccasionChecked,
                          (value) {
                        setState(() {
                          isOccasionChecked = value!;
                        });
                      }, true),
                      buildCustomCheckbox("On Demand", isOnDemandChecked,
                          (value) {
                        setState(() {
                          isOnDemandChecked = value!;
                        });
                      }, true),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text("Add Ons"),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: [
                      buildCustomCheckbox("Trainers", isTrainerChecked,
                          (value) {
                        setState(() {
                          isTrainerChecked = value!;
                        });
                      }, true),
                      buildCustomCheckbox("A.C", isACChecked, (value) {
                        setState(() {
                          isACChecked = value!;
                        });
                      }, true),
                      buildCustomCheckbox("Cleaners", isCleanersChecked,
                          (value) {
                        setState(() {
                          isCleanersChecked = value!;
                        });
                      }, true),
                      buildCustomCheckbox("Wi-Fi", isWiFiChecked, (value) {
                        setState(() {
                          isWiFiChecked = value!;
                        });
                      }, true),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            buildCustomCheckbox("Cleaning Services", isCleaningServicesChecked,
                (value) {
              setState(() {
                isCleaningServicesChecked = value!;
              });
            }, false),
            const SizedBox(height: 10),
            buildCustomCheckbox("Training Services", isTrainingServicesChecked,
                (value) {
              setState(() {
                isTrainingServicesChecked = value!;
              });
            }, false),
            const SizedBox(height: 10),
            buildCustomCheckbox(
                "Photography Services", isPhotographyServicesChecked, (value) {
              setState(() {
                isPhotographyServicesChecked = value!;
              });
            }, false),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor:
                        index == 2 ? Colors.black : Colors.grey.shade400,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBackgroundColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterFour(),
                    ),
                  );
                },
                child: const Text(
                  'CONTINUE',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
