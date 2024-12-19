import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/commons/views/providers/authprovider.dart';
import 'package:studio_partner_app/src/feature/profile/controllers/profile_controller.dart';
import 'package:studio_partner_app/src/feature/profile/views/widgets/global_image_builder.dart';
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
      _restaurantNameController,
      _restaurantAddressController,
      _restaurantAddressLine2Controller,
      _restaurantCityController;
  //     _avatar;
  // XFile? _image;

  @override
  void initState() {
    final currentUser = ref.read(currentUserProvider);
    _nameController = TextEditingController(text: currentUser!.name);
    _phoneController = TextEditingController(text: currentUser.phone);
    _restaurantNameController =
        TextEditingController(text: currentUser.businessName);
    _restaurantAddressController =
        TextEditingController(text: currentUser.address);
    _restaurantAddressLine2Controller =
        TextEditingController(text: currentUser.pincode);
    _restaurantCityController = TextEditingController(text: currentUser.city);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.read(currentUserProvider);
    String avatarURL = currentUser!.avatar ??
        "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.vecteezy.com%2Ffree-png%2Fuser&psig=AOvVaw0YK0y000AuHKxye8bJVFN1&ust=1732025299876000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCLimlJmH5okDFQAAAAAdAAAAABAE";
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
                    SizedBox(
                      height: 110,
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
                    // CircleAvatar(
                    //   radius: 50,
                    //   backgroundColor: Colors.grey.shade300,
                    //   backgroundImage: image == null
                    //       ? null
                    //       : FileImage(
                    //           File(image!.path),
                    //         ),
                    //   child: image == null
                    //       ? IconButton(
                    //           icon: const Icon(Icons.edit, color: Colors.white),
                    //           onPressed: () {
                    //             Pickimage(ref).pickImage().then((value) {
                    //               final userImage = ref.watch(keyProvider);
                    //               setState(() {
                    //                 image = value;
                    //                 _avatar =
                    //                     '${ImageAssets.userProfile}$userImage';
                    //               });
                    //             });
                    //           },
                    //         )
                    //       : null,
                    // ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: _nameController,
                      hintText: 'John Doe',
                      prefixIcon: Icons.person,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: _phoneController,
                      hintText: '+91 XXXXXX XXXXX',
                      prefixIcon: Icons.phone,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: _restaurantNameController,
                      label: 'Business Name',
                      hintText: 'ABC XYZ Restaurant',
                      prefixIcon: Icons.restaurant,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: _restaurantAddressController,
                      label: 'Personal Address',
                      hintText: '111, ABC Apartments',
                      prefixIcon: Icons.location_city,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: _restaurantAddressLine2Controller,
                      hintText: 'XYZ Road, New Delhi',
                      prefixIcon: Icons.location_on,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: _restaurantCityController,
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
                    final selectedImageFile = ref.watch(
                        profileController.select((value) => value?.avatarFile));
                    final updatedProfile = Profile(
                      name: _nameController.text,
                      // phone: _phone,
                      businessName: _restaurantNameController.text,
                      address: _restaurantAddressController.text,
                      pincode: _restaurantAddressLine2Controller.text,
                      // state: ,
                      city: _restaurantCityController.text,
                      // country: _country,
                    );

                    // Call the controller method with the updated profile
                    ref.read(profileController.notifier).updateProfile(
                        context: context,
                        ref: ref,
                        profile: updatedProfile,
                        file: selectedImageFile);
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
    TextEditingController? controller,
    String? label,
    required String hintText,
    IconData? prefixIcon,
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
          controller: controller,
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
