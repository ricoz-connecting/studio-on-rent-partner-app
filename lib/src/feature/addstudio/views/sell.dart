import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/feature/addstudio/views/widgets/add_image.dart';
import 'package:studio_partner_app/src/feature/addstudio/views/widgets/chip_selection.dart';
import 'package:studio_partner_app/src/feature/addstudio/views/widgets/custom_textfield.dart';
import 'package:studio_partner_app/src/feature/addstudio/views/widgets/facilities_chip.dart';
import 'package:studio_partner_app/src/feature/addstudio/views/widgets/rental_widget.dart';

class Sell extends StatefulWidget {
  const Sell({super.key});

  @override
  State<Sell> createState() => _SellState();
}

class _SellState extends State<Sell> {
  List<String>? facilities = [];
  bool isAnySelected = false,
      isWifiSelected = false,
      isSelfCheckInSelected = false,
      isTimeSelected = false,
      isFreeCancelSelected = false,
      isFreeParkingSelected = false,
      isSecuritySelected = false,
      isMembersSelected = false,
      isAirConditionerSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: AddImage(),
                ),
                Center(
                  child: Text(
                    'Add Thumbnail',
                    style: GoogleFonts.inter(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20),
                const CustomTextField(
                  hintText: 'Studio Name*',
                ),
                const SizedBox(height: 20),
                Text(
                  'Category',
                  style: GoogleFonts.inter(fontSize: 16),
                ),
                const SizedBox(height: 10),
                ChipSelection(
                  onCategorySelected: (category) {},
                ),
                const SizedBox(height: 20),
                const CustomTextField(
                  hintText: 'About Studio',
                  keyboardType: TextInputType.multiline,
                ),
                TextButton(
                  onPressed: () {},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.location_on_outlined),
                      Text('Select From Maps'),
                    ],
                  ),
                ),
                const CustomTextField(
                  icon: Icons.location_on_outlined,
                  hintText: 'Address Line 1',
                ),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        icon: Icons.location_on_outlined,
                        hintText: 'City',
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CustomTextField(
                        icon: Icons.location_on_outlined,
                        hintText: 'State',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const CustomTextField(
                  icon: Icons.location_on_outlined,
                  hintText: 'Pincode',
                ),
                const SizedBox(height: 10),
                const CustomTextField(
                  icon: Icons.location_on_outlined,
                  hintText: 'Area(Sq. Ft)',
                ),
                const SizedBox(height: 10),
                Text(
                  'Property Facilities',
                  style: GoogleFonts.inter(fontSize: 16),
                ),
                Wrap(
                  spacing: 10,
                  children: [
                    FacilitiesChip(
                      isSelected: isAnySelected,
                      onTap: () {
                        setState(() {
                          isAnySelected = !isAnySelected;
                          isAnySelected
                              ? facilities?.add('Any')
                              : facilities?.remove('Any');
                        });
                      },
                      label: 'Any',
                    ),
                    FacilitiesChip(
                      isSelected: isWifiSelected,
                      onTap: () {
                        setState(() {
                          isWifiSelected = !isWifiSelected;
                          isWifiSelected
                              ? facilities?.add('WiFi')
                              : facilities?.remove('WiFi');
                        });
                      },
                      label: 'WiFi',
                    ),
                    FacilitiesChip(
                      isSelected: isSelfCheckInSelected,
                      onTap: () {
                        setState(() {
                          isSelfCheckInSelected = !isSelfCheckInSelected;
                          isSelfCheckInSelected
                              ? facilities?.add('Self check-in')
                              : facilities?.remove('Self check-in');
                        });
                      },
                      label: 'Self check-in',
                    ),
                    FacilitiesChip(
                      isSelected: isTimeSelected,
                      onTap: () {
                        setState(() {
                          isTimeSelected = !isTimeSelected;
                          isTimeSelected
                              ? facilities?.add('time')
                              : facilities?.remove('time');
                        });
                      },
                      label: 'time',
                    ),
                    FacilitiesChip(
                      isSelected: isFreeCancelSelected,
                      onTap: () {
                        setState(() {
                          isFreeCancelSelected = !isFreeCancelSelected;
                          isFreeCancelSelected
                              ? facilities?.add('Free cancel')
                              : facilities?.remove('Free cancel');
                        });
                      },
                      label: 'Free cancel',
                    ),
                    FacilitiesChip(
                      isSelected: isSecuritySelected,
                      onTap: () {
                        setState(() {
                          isSecuritySelected = !isSecuritySelected;
                          isSecuritySelected
                              ? facilities?.add('Security')
                              : facilities?.remove('Security');
                        });
                      },
                      label: 'Security',
                    ),
                    FacilitiesChip(
                      isSelected: isMembersSelected,
                      onTap: () {
                        setState(() {
                          isMembersSelected = !isMembersSelected;
                          isMembersSelected
                              ? facilities?.add('Members')
                              : facilities?.remove('Members');
                        });
                      },
                      label: 'Members',
                    ),
                    FacilitiesChip(
                      isSelected: isFreeParkingSelected,
                      onTap: () {
                        setState(() {
                          isFreeParkingSelected = !isFreeParkingSelected;
                          isFreeParkingSelected
                              ? facilities?.add('Free Parking')
                              : facilities?.remove('Free Parking');
                        });
                      },
                      label: 'Free Parking',
                    ),
                    FacilitiesChip(
                      isSelected: isAirConditionerSelected,
                      onTap: () {
                        setState(() {
                          isAirConditionerSelected = !isAirConditionerSelected;
                          isAirConditionerSelected
                              ? facilities?.add('Air Conditioner')
                              : facilities?.remove('Air Conditioner');
                        });
                      },
                      label: 'Air Conditioner',
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'Add Images',
                  style: GoogleFonts.inter(fontSize: 16),
                ),
                const SizedBox(height: 10),
                const AddImage(),
                const SizedBox(height: 10),
                Text(
                  'Pricing',
                  style: GoogleFonts.inter(fontSize: 16),
                ),
                const SizedBox(height: 10),
                const RentalWidget(
                  label: "Sell",
                ),
                const SizedBox(height: 10),
                const CustomTextField(
                  icon: Icons.price_change_outlined,
                  hintText: 'Final Price',
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
