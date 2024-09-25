import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/feature/addstudio/views/widgets/add_image.dart';
import 'package:studio_partner_app/src/feature/addstudio/views/widgets/chip_selection.dart';
import 'package:studio_partner_app/src/feature/addstudio/views/widgets/custom_textfield.dart';
import 'package:studio_partner_app/src/feature/addstudio/views/widgets/facilities_chip.dart';
import 'package:studio_partner_app/src/feature/addstudio/views/widgets/rental_widget.dart';
import 'package:studio_partner_app/src/feature/addstudio/views/widgets/request_button.dart';

class Sell extends StatelessWidget {
  const Sell({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
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
                const ChipSelection(),
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
                const Wrap(
                  spacing: 10,
                  children: [
                    FacilitiesChip(
                      label: 'Any',
                    ),
                    FacilitiesChip(
                      label: 'WiFi',
                    ),
                    FacilitiesChip(
                      label: 'Self check-in',
                    ),
                    FacilitiesChip(
                      label: 'time',
                    ),
                    FacilitiesChip(
                      label: 'Free cancel',
                    ),
                    FacilitiesChip(
                      label: 'Free parking',
                    ),
                    FacilitiesChip(
                      label: 'Security',
                    ),
                    FacilitiesChip(
                      label: 'Members',
                    ),
                    FacilitiesChip(
                      label: 'Free Parking',
                    ),
                    FacilitiesChip(
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
      bottomSheet: const AddStudioRequestButton(),
    );
  }
}
