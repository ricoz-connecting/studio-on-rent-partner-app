import 'package:flutter/material.dart';
import 'package:studio_partner_app/commons/views/widgets/custom_appbar.dart';
import 'package:studio_partner_app/src/feature/addstudio/views/widgets/availability_card.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class WeeklyAvailabilityPage extends StatefulWidget {
  const WeeklyAvailabilityPage({super.key});

  @override
  WeeklyAvailabilityPageState createState() => WeeklyAvailabilityPageState();
}

class WeeklyAvailabilityPageState extends State<WeeklyAvailabilityPage> {
  Map<String, bool> isDayOff = {
    "Monday": false,
    "Tuesday": false,
    "Wednesday": false,
    "Thursday": false,
    "Friday": false,
    "Saturday": false,
    "Sunday": true,
  };

  Map<String, TimeOfDay?> morningStartTimes = {};
  Map<String, TimeOfDay?> morningEndTimes = {};
  Map<String, TimeOfDay?> eveningStartTimes = {};
  Map<String, TimeOfDay?> eveningEndTimes = {};

  void _pickTime(String day, bool isMorning, bool isStart) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isMorning) {
          if (isStart) {
            morningStartTimes[day] = picked;
          } else {
            morningEndTimes[day] = picked;
          }
        } else {
          if (isStart) {
            eveningStartTimes[day] = picked;
          } else {
            eveningEndTimes[day] = picked;
          }
        }
      });
    }
  }

  void _openUnavailabilityPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UnavailabilityPickerPage()),
    );
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
            onPressed: _openUnavailabilityPage,
            child: const Text(
              "Manage Unavailability",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShiftRow(String day, String shift, bool isMorning) {
    return Column(
      children: [
        Text("$shift Shift",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => _pickTime(day, isMorning, true),
              child: Text(
                isMorning
                    ? (morningStartTimes[day]?.format(context) ?? "Start Time")
                    : (eveningStartTimes[day]?.format(context) ?? "Start Time"),
              ),
            ),
            ElevatedButton(
              onPressed: () => _pickTime(day, isMorning, false),
              child: Text(
                isMorning
                    ? (morningEndTimes[day]?.format(context) ?? "End Time")
                    : (eveningEndTimes[day]?.format(context) ?? "End Time"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────────────────
// Unavailability Picker Page
// ────────────────────────────────────────────────────────────────────────────────────────

class UnavailabilityPickerPage extends StatefulWidget {
  @override
  _UnavailabilityPickerPageState createState() =>
      _UnavailabilityPickerPageState();
}

class _UnavailabilityPickerPageState extends State<UnavailabilityPickerPage> {
  List<DateTime> unavailableDates = [];
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  TimeOfDay? autoResumeTime;

  void _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (picked != null && !unavailableDates.contains(picked)) {
      setState(() {
        unavailableDates.add(picked);
      });
    }
  }

  void _pickTime(Function(TimeOfDay) onTimePicked) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        onTimePicked(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage Unavailability")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _pickDate,
              child: Text("Select Date(s)"),
            ),
            Wrap(
              children: unavailableDates.map((date) {
                return Chip(
                  label: Text("${date.day}/${date.month}/${date.year}"),
                  onDeleted: () {
                    setState(() {
                      unavailableDates.remove(date);
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Text("Choose Unavailable Time Slot",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _pickTime((t) => startTime = t),
                  child: Text(startTime == null
                      ? "Start Time"
                      : startTime!.format(context)),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => _pickTime((t) => endTime = t),
                  child: Text(
                      endTime == null ? "End Time" : endTime!.format(context)),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text("Set Auto-Resume Time",
                style: TextStyle(fontWeight: FontWeight.bold)),
            ElevatedButton(
              onPressed: () => _pickTime((t) => autoResumeTime = t),
              child: Text(autoResumeTime == null
                  ? "Auto-Resume Time"
                  : autoResumeTime!.format(context)),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Save & Back", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
