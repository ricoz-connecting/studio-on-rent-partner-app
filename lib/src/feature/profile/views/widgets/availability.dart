import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/commons/views/providers/authprovider.dart';
import 'package:studio_partner_app/commons/views/widgets/custom_appbar.dart';
import 'package:studio_partner_app/src/feature/addstudio/views/widgets/availability_card.dart';
import 'package:studio_partner_app/src/feature/profile/controllers/availabilityController.dart';
import 'package:studio_partner_app/src/models/partnerAvailability.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class WeeklyAvailabilityPage extends ConsumerStatefulWidget {
  const WeeklyAvailabilityPage({super.key});

  @override
  WeeklyAvailabilityPageState createState() => WeeklyAvailabilityPageState();
}

class WeeklyAvailabilityPageState
    extends ConsumerState<WeeklyAvailabilityPage> {
  Map<String, bool> isDayOff = {
    "Monday": false,
    "Tuesday": false,
    "Wednesday": false,
    "Thursday": false,
    "Friday": false,
    "Saturday": false,
    "Sunday": true,
  };

  Map<String, String?> morningStartTimes = {};
  Map<String, String?> morningEndTimes = {};
  Map<String, String?> eveningStartTimes = {};
  Map<String, String?> eveningEndTimes = {};

  // void _pickTime(String day, bool isMorning, bool isStart) async {
  //   TimeOfDay? picked = await showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(),
  //   );
  //   if (picked != null) {
  //     setState(() {
  //       if (isMorning) {
  //         if (isStart) {
  //           morningStartTimes[day] = picked.format(context);
  //         } else {
  //           morningEndTimes[day] = picked.format(context);
  //         }
  //       } else {
  //         if (isStart) {
  //           eveningStartTimes[day] = picked.format(context);
  //         } else {
  //           eveningEndTimes[day] = picked.format(context);
  //         }
  //       }
  //     });
  //   }
  // }
  void _pickTime(String day, bool isMorning, bool isStart) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      final formattedTime = picked.format(context);

      setState(() {
        // Update local maps if needed (optional)
        if (isMorning) {
          if (isStart) {
            morningStartTimes[day] = formattedTime;
          } else {
            morningEndTimes[day] = formattedTime;
          }
        } else {
          if (isStart) {
            eveningStartTimes[day] = formattedTime;
          } else {
            eveningEndTimes[day] = formattedTime;
          }
        }
      });

      // Call updateDayAvailability to update state
      ref.read(availabilityControllerProvider.notifier).updateDayAvailability(
            day: day,
            isAvailable: true,
            morningStart: isMorning && isStart ? formattedTime : null,
            morningEnd: isMorning && !isStart ? formattedTime : null,
            eveningStart: !isMorning && isStart ? formattedTime : null,
            eveningEnd: !isMorning && !isStart ? formattedTime : null,
          );
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final user = ref.read(currentUserProvider);
      final controller = ref.read(availabilityControllerProvider.notifier);

      await controller.getAvailability(
        partnerDocId: user!.id,
        context: context,
      );

      final data = ref.read(availabilityControllerProvider);

      if (data != null) {
        final dayMap = {
          'Monday': data.monday,
          'Tuesday': data.tuesday,
          'Wednesday': data.wednesday,
          'Thursday': data.thursday,
          'Friday': data.friday,
          'Saturday': data.saturday,
          'Sunday': data.sunday,
        };

        dayMap.forEach((day, dayData) {
          if (dayData != null) {
            isDayOff[day] = !(dayData.isAvailable ?? false);
            // Morning Shift
            morningStartTimes[day] = dayData.morningShift?.startTime;
            morningEndTimes[day] = dayData.morningShift?.endTime;
            // Evening Shift
            eveningStartTimes[day] = dayData.eveningShift?.startTime;
            eveningEndTimes[day] = (dayData.eveningShift?.endTime);
          }
        });

        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Availability"),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (var day in isDayOff.keys)
            AvailabilityCard(
              day: day,
              isDayOff: isDayOff[day]!,
              onToggle: (value) {
                setState(() {
                  isDayOff[day] = value;
                  if (value) {
                    morningStartTimes.remove(day);
                    morningEndTimes.remove(day);
                    eveningStartTimes.remove(day);
                    eveningEndTimes.remove(day);
                  }
                });
                ref
                    .read(availabilityControllerProvider.notifier)
                    .updateDayAvailability(
                      day: day,
                      isAvailable: !value,
                    );
              },
              morningStartTime: morningStartTimes[day],
              morningEndTime: morningEndTimes[day],
              eveningStartTime: eveningStartTimes[day],
              eveningEndTime: eveningEndTimes[day],
              pickTime: _pickTime,
            ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBackgroundColor,
            ),
            onPressed: () {
              final user = ref.read(currentUserProvider);

              ref
                  .read(availabilityControllerProvider.notifier)
                  .updateAvailability(context: context, partnerDocId: user!.id);
            },
            child: const Text(
              "Update",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
