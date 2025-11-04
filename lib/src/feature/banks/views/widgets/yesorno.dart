// import 'package:flutter/material.dart';

// class YesNoDropdown extends StatefulWidget {
//   final String? initialValue;
//   final ValueChanged<String?> onChanged;

//   const YesNoDropdown({super.key, this.initialValue, required this.onChanged});

//   @override
//   State<YesNoDropdown> createState() => _YesNoDropdownState();
// }

// class _YesNoDropdownState extends State<YesNoDropdown> {
//   String? selectedValue;

//   @override
//   void initState() {
//     super.initState();
//     selectedValue = widget.initialValue ?? "Yes";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       value: selectedValue,
//       items: const [
//         DropdownMenuItem(value: "Yes", child: Text("Yes")),
//         DropdownMenuItem(value: "No", child: Text("No")),
//       ],
//       onChanged: (value) {
//         setState(() {
//           selectedValue = value;
//         });
//         widget.onChanged(value);
//       },
//       style: const TextStyle(color: Colors.black, fontSize: 16),
//       dropdownColor: Colors.white,
//       icon: const Icon(Icons.arrow_drop_down),
//       underline: Container(height: 1, color: Colors.grey),
//     );
//   }
// }

import 'package:flutter/material.dart';

class YesNoDropdown extends StatefulWidget {
  final String? initialValue;
  final ValueChanged<String?> onChanged;

  const YesNoDropdown({super.key, this.initialValue, required this.onChanged});

  @override
  State<YesNoDropdown> createState() => _YesNoDropdownState();
}

class _YesNoDropdownState extends State<YesNoDropdown> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue ?? "Yes";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Full width
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ), // Optional padding
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: selectedValue,
        isExpanded: true, // Important for full width!
        items: const [
          DropdownMenuItem(value: "Yes", child: Text("Yes")),
          DropdownMenuItem(value: "No", child: Text("No")),
        ],
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
          widget.onChanged(value);
        },
        style: const TextStyle(color: Colors.black, fontSize: 16),
        dropdownColor: Colors.white,
        icon: const Icon(Icons.arrow_drop_down),
        underline: Container(), // Remove default underline
      ),
    );
  }
}
