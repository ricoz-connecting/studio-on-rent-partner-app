import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class PropertySearchWidget extends StatefulWidget {
  const PropertySearchWidget({super.key});

  @override
  State<PropertySearchWidget> createState() => _PropertySearchWidgetState();
}

class _PropertySearchWidgetState extends State<PropertySearchWidget> {
  String rentOrBuy = 'rent';
  String selectedPropertyType = 'Studio';
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(const Duration(days: 30)),
  );

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != dateRange) {
      setState(() {
        dateRange = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      width: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSegmentedControlButton("I need to rent", 'rent'),
              _buildSegmentedControlButton("I need to buy", 'buy'),
            ],
          ),
          const SizedBox(height: 16),
          Text("Enter location", style: TextStyle(color: Colors.grey[600])),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: "Enter city, location",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text("How long do you want to stay?",
              style: TextStyle(color: Colors.grey[600])),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => _selectDateRange(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Text(
                    "${dateRange.start.day} ${_monthAbbreviation(dateRange.start.month)} - ${dateRange.end.day} ${_monthAbbreviation(dateRange.end.month)}",
                    style: TextStyle(color: Colors.grey[800]),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text("Property type", style: TextStyle(color: Colors.grey[600])),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPropertyTypeButton("Any"),
              _buildPropertyTypeButton("Studio"),
              _buildPropertyTypeButton("1 BHK"),
              _buildPropertyTypeButton("2 BHK"),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBackgroundColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                "Show Results",
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _monthAbbreviation(int month) {
    List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  Widget _buildSegmentedControlButton(String text, String value) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            rentOrBuy = value;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: rentOrBuy == value
                ? AppColors.primaryBackgroundColor
                : Colors.grey[200],
            borderRadius: BorderRadius.circular(30),
            boxShadow: rentOrBuy == value
                ? [
                    BoxShadow(
                        color:
                            AppColors.primaryBackgroundColor.withOpacity(0.5),
                        blurRadius: 10)
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.plusJakartaSans(
                color: rentOrBuy == value ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPropertyTypeButton(String type) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPropertyType = type;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: selectedPropertyType == type
              ? AppColors.primaryBackgroundColor
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          type,
          style: GoogleFonts.poppins(
            color: selectedPropertyType == type ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
