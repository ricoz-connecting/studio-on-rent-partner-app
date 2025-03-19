import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/feature/addstudio/views/widgets/custom_switch.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class ShiftTimePickerRow extends StatelessWidget {
  final String shift;
  final String day;
  final bool isMorning;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final Function(String, bool, bool) pickTime;

  const ShiftTimePickerRow({
    super.key,
    required this.shift,
    required this.day,
    required this.isMorning,
    required this.startTime,
    required this.endTime,
    required this.pickTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            "$shift Shift",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              color: AppColors.primaryBackgroundColor,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 2),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => pickTime(day, isMorning, true),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: 100,
                  height: 30,
                  child: Center(
                    child: Text(
                      startTime?.format(context) ?? "Start Time",
                      style: GoogleFonts.poppins(
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () => pickTime(day, isMorning, false),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: 100,
                  height: 30,
                  child: Center(
                    child: Text(
                      endTime?.format(context) ?? "End Time",
                      style: GoogleFonts.poppins(
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AvailabilityCard extends StatelessWidget {
  final String day;
  final bool isDayOff;
  final ValueChanged<bool> onToggle;
  final TimeOfDay? morningStartTime;
  final TimeOfDay? morningEndTime;
  final TimeOfDay? eveningStartTime;
  final TimeOfDay? eveningEndTime;
  final Function(String, bool, bool) pickTime;

  const AvailabilityCard({
    super.key,
    required this.day,
    required this.isDayOff,
    required this.onToggle,
    required this.morningStartTime,
    required this.morningEndTime,
    required this.eveningStartTime,
    required this.eveningEndTime,
    required this.pickTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFF4F6F9),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          ListTile(
            title: Row(
              children: [
                Text(
                  day,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const Spacer(),
                CustomSwitch(value: isDayOff, onChanged: onToggle),
              ],
            ),
            subtitle: isDayOff
                ? Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      "Day Off",
                      style: GoogleFonts.poppins(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  )
                : Column(
                    children: [
                      ShiftTimePickerRow(
                        shift: "Morning",
                        day: day,
                        isMorning: true,
                        startTime: morningStartTime,
                        endTime: morningEndTime,
                        pickTime: pickTime,
                      ),
                      ShiftTimePickerRow(
                        shift: "Evening",
                        day: day,
                        isMorning: false,
                        startTime: eveningStartTime,
                        endTime: eveningEndTime,
                        pickTime: pickTime,
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
