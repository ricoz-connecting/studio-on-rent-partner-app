import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/commons/views/providers/authprovider.dart';
import 'package:studio_partner_app/commons/views/widgets/custom_appbar.dart';
import 'package:studio_partner_app/src/feature/profile/controllers/profile_controller.dart';
import 'package:studio_partner_app/src/feature/profile/views/widgets/global_image_builder.dart';
import 'package:studio_partner_app/src/feature/profile/views/widgets/profile_text_field.dart';
import 'package:studio_partner_app/src/res/colors.dart';

import '../models/profile.dart';

class EditProfile extends ConsumerStatefulWidget {
  const EditProfile({super.key});

  @override
  ConsumerState<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  late TextEditingController _nameController,
      _phoneController,
      _businessNameController,
      _addressController,
      _addressLine2Controller,
      _cityController,
      _stateController,
      _countryController;

  @override
  void initState() {
    final currentUser = ref.read(currentUserProvider);
    _nameController = TextEditingController(text: currentUser!.name);
    _phoneController = TextEditingController(text: currentUser.phone);
    _businessNameController =
        TextEditingController(text: currentUser.businessName);
    _addressController = TextEditingController(text: currentUser.address);
    _addressLine2Controller = TextEditingController(text: currentUser.pincode);
    _cityController = TextEditingController(text: currentUser.city);
    _stateController = TextEditingController(text: currentUser.state);
    _countryController = TextEditingController(text: currentUser.country);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.read(currentUserProvider);
    String? avatarURL = currentUser!.avatar;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Edit Profile'),
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
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Consumer(
                        builder: (context, ref, child) {
                          final selectedImageFile = ref.watch(profileController
                              .select((value) => value?.avatarFile));
                          return InkWell(
                            onTap: () {
                              ref
                                  .read(profileController.notifier)
                                  .selectFile('avatar');
                            },
                            child: ClipOval(
                              child: GlobalImageBuilder(
                                src: avatarURL,
                                file: selectedImageFile,
                                height: 110,
                                width: 110,
                                icon: Icons.person,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    ProfileTextfield(
                      hintText: 'Enter Name',
                      controller: _nameController,
                      prefixIcon: Icons.person,
                    ),
                    const SizedBox(height: 10),
                    ProfileTextfield(
                      hintText: 'Enter Phone Number',
                      controller: _phoneController,
                      prefixIcon: Icons.phone,
                      enabled: false,
                    ),
                    const SizedBox(height: 10),
                    ProfileTextfield(
                      controller: _businessNameController,
                      label: 'Business Name',
                      hintText: 'Enter Business Name',
                      prefixIcon: Icons.business,
                    ),
                    const SizedBox(height: 10),
                    ProfileTextfield(
                      controller: _addressController,
                      label: 'Personal Address',
                      hintText: 'Enter Address',
                      prefixIcon: Icons.location_city,
                    ),
                    const SizedBox(height: 10),
                    ProfileTextfield(
                      controller: _addressLine2Controller,
                      hintText: 'Enter Pincode',
                      prefixIcon: Icons.location_on,
                    ),
                    const SizedBox(height: 10),
                    ProfileTextfield(
                      controller: _cityController,
                      hintText: 'Enter City',
                      prefixIcon: Icons.map,
                    ),
                    const SizedBox(height: 10),
                    ProfileTextfield(
                      controller: _stateController,
                      hintText: 'Enter State',
                      prefixIcon: Icons.map,
                    ),
                    const SizedBox(height: 10),
                    ProfileTextfield(
                      controller: _countryController,
                      hintText: 'Enter Country',
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
                    final selectedImageFile = ref.watch(
                        profileController.select((value) => value?.avatarFile));
                    final updatedProfile = Profile(
                      name: _nameController.text,
                      businessName: _businessNameController.text,
                      address: _addressController.text,
                      pincode: _addressLine2Controller.text,
                      state: _stateController.text,
                      city: _cityController.text,
                      country: _countryController.text,
                    );

                    ref.read(profileController.notifier).updateProfile(
                          context: context,
                          ref: ref,
                          profile: updatedProfile,
                          file: selectedImageFile,
                        );
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
}
