import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studio_partner_app/commons/views/providers/image_upload_url.dart';
import 'package:studio_partner_app/src/feature/profile/controllers/editprofile.dart';
import 'package:studio_partner_app/src/feature/profile/views/widgets/pickimage.dart';
import 'package:studio_partner_app/src/res/assets.dart';
import 'package:studio_partner_app/src/res/colors.dart';

import '../../models/profile.dart';

class EditProfile extends ConsumerStatefulWidget {
  const EditProfile({super.key});

  @override
  ConsumerState<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  String? _name,
      _restaurantName,
      _restaurantAddress,
      _restaurantAddressLine2,
      _restaurantCity,
      _avatar;
  XFile? image;

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
          textAlign: TextAlign.left,
          'Edit Profile',
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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage: image == null
                          ? null
                          : FileImage(
                              File(image!.path),
                            ),
                      child: image == null
                          ? IconButton(
                              icon: const Icon(Icons.edit, color: Colors.white),
                              onPressed: () {
                                Pickimage(ref).pickImage().then((value) {
                                  final userImage = ref.watch(keyProvider);
                                  setState(() {
                                    image = value;
                                    _avatar =
                                        '${ImageAssets.userProfile}$userImage';
                                  });
                                });
                              },
                            )
                          : null,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      onChanged: (value) {
                        setState(() {
                          _name = value;
                        });
                      },
                      hintText: 'John Doe',
                      prefixIcon: Icons.person,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      onChanged: (value) {
                        setState(() {});
                      },
                      hintText: '+91 XXXXXX XXXXX',
                      prefixIcon: Icons.phone,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      onChanged: (value) {
                        setState(() {
                          _restaurantName = value;
                        });
                      },
                      label: 'Restaurant Name',
                      hintText: 'ABC XYZ Restaurant',
                      prefixIcon: Icons.restaurant,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      onChanged: (value) {
                        setState(() {
                          _restaurantAddress = value;
                        });
                      },
                      label: 'Restaurant Address',
                      hintText: '111, ABC Apartments',
                      prefixIcon: Icons.location_city,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      onChanged: (value) {
                        setState(() {
                          _restaurantAddressLine2 = value;
                        });
                      },
                      hintText: 'XYZ Road, New Delhi',
                      prefixIcon: Icons.location_on,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      onChanged: (value) {
                        setState(() {
                          _restaurantCity = value;
                        });
                      },
                      hintText: 'Delhi',
                      prefixIcon: Icons.map,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
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
                    Editprofile(
                      profile: Profile(
                          name: _name,
                          businessName: _restaurantName,
                          address: _restaurantAddress,
                          city: _restaurantCity,
                          pincode: _restaurantAddressLine2,
                          avatar: _avatar),
                    ).editProfile(ref, context);
                  },
                  child: const Text(
                    'SAVE',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    String? label,
    required String hintText,
    IconData? prefixIcon,
    required void Function(String) onChanged,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              label,
              style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        TextField(
          onChanged: onChanged,
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
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey.shade500),
          ),
        ),
      ],
    );
  }
}
