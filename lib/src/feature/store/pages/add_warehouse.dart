import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class AddWarehouseRequest extends StatelessWidget {
  const AddWarehouseRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Add Warehouse Request',
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildTextField(
                label: '',
                hintText: 'Warehouse Name*',
              ),
              const SizedBox(height: 1),
              _buildTextField(
                hintText: 'Starting Bid',
                prefixIcon: Icons.money,
                label: '',
              ),
              const SizedBox(height: 1),
              _buildTextField(
                label: '',
                hintText: 'Maximum Bid',
                prefixIcon: Icons.money,
              ),
              const SizedBox(height: 1),
              _buildTextField(
                label: '',
                hintText: 'Address *',
                prefixIcon: Icons.location_on,
              ),
              const SizedBox(height: 1),
              Text(
                'Category',
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: [
                  _buildCategoryChip(context, 'Dance', selected: true),
                  _buildCategoryChip(context, 'Photography'),
                  _buildCategoryChip(context, 'Misc.'),
                  _buildCategoryChip(context, 'Luxury'),
                ],
              ),
              const SizedBox(height: 20),
              _buildTextField(
                label: 'About Warehouse',
                hintText: '',
                maxLines: 4,
              ),
              const SizedBox(height: 20),
              Text(
                'Add Image',
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(
                    Icons.add_photo_alternate_outlined,
                    size: 40,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
                    // Add your onPressed code here!
                  },
                  child: const Text(
                    'Post Add Warehouse Request',
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
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hintText,
    IconData? prefixIcon,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.lato(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: Colors.black)
                : null,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 14,
            ),
            filled: true,
            fillColor: Colors.white,
            // Remove outline border
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey.shade500),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryChip(BuildContext context, String label,
      {bool selected = false}) {
    return ChoiceChip(
      label: Text(label),
      labelStyle: GoogleFonts.lato(
        fontSize: 14,
        color: selected ? Colors.white : Colors.black,
      ),
      selected: selected,
      onSelected: (value) {
        // Add your onSelected code here!
      },
      selectedColor: AppColors.primaryBackgroundColor,
      backgroundColor: Colors.grey.shade200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: AddWarehouseRequest()));
}
