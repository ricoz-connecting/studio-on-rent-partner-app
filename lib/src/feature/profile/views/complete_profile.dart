import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studio_partner_app/commons/views/location_access.dart';
import 'package:studio_partner_app/commons/views/providers/authprovider.dart';
import 'package:studio_partner_app/src/feature/profile/controllers/profile_controller.dart';
import 'package:studio_partner_app/src/feature/profile/models/profile.dart';
import 'package:studio_partner_app/src/feature/profile/views/widgets/global_image_builder.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class CompleteProfileScreen extends ConsumerStatefulWidget {
  const CompleteProfileScreen({
    super.key,
  });

  @override
  ConsumerState<CompleteProfileScreen> createState() =>
      _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends ConsumerState<CompleteProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bussinessNameController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? name;
  String? businessName;
  String? gender;
  XFile? image;

  @override
  Widget build(BuildContext context) {
    final userProfile = ref.watch(currentUserProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Complete Your Profile',
                style: GoogleFonts.inter(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Don't worry, only you can see your personal data. No one else will be able to see it.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 110,
                width: 100,
                child: Consumer(
                  builder: (context, ref, child) {
                    final selectedImageFile = ref.watch(
                        profileController.select((value) => value?.avatarFile));
                    return InkWell(
                      onTap: () {
                        ref
                            .read(profileController.notifier)
                            .selectFile('avatar');
                      },
                      child: ClipOval(
                        child: GlobalImageBuilder(
                          src: userProfile?.avatar,
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
              // Stack(
              //   children: [
              //     CircleAvatar(
              //       radius: 50,
              //       backgroundColor: Colors.grey.shade200,
              //       backgroundImage:
              //           image == null ? null : FileImage(File(image!.path)),
              //       child: image == null
              //           ? const Icon(
              //               Icons.person,
              //               size: 60,
              //               color: Colors.grey,
              //             )
              //           : null,
              //     ),
              //     Positioned(
              //       right: 0,
              //       bottom: 0,
              //       child: Container(
              //         decoration: const BoxDecoration(
              //           color: AppColors.primaryBackgroundColor,
              //           shape: BoxShape.circle,
              //         ),
              //         child: Padding(
              //           padding: const EdgeInsets.all(4.0),
              //           child: GestureDetector(
              //             onTap: () {
              //               Pickimage(ref).pickImage().then((value) {
              //                 setState(() {
              //                   image = value;
              //                 });
              //               });
              //             },
              //             child: const Icon(
              //               Icons.edit,
              //               size: 18,
              //               color: Colors.white,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Name',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _nameController,
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 14,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Rishav Bhardwaz',
                ),
              ),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Business Name',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _bussinessNameController,
                onChanged: (value) {
                  setState(() {
                    businessName = value;
                  });
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 14,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'ABC Enterprises',
                ),
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Gender',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 14,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                value: 'male',
                items: const [
                  DropdownMenuItem(value: 'male', child: Text('Male')),
                  DropdownMenuItem(value: 'female', child: Text('Female')),
                  DropdownMenuItem(value: 'other', child: Text('Other')),
                ],
                onChanged: (value) {
                  setState(() {
                    gender = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Phone Number',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        textAlign: TextAlign.center,
                        '+91',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: _phoneController,
                      onChanged: (value) {
                        setState(() {
                          _phoneController.text = value;
                        });
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 14,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        hintText: '9534525555',
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBackgroundColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(90),
                    ),
                  ),
                  onPressed: () async {
                    final userLocation =
                        await GetUserLocation.determinePosition();
                    // context.mounted
                    //     ? Editprofile(
                    //         profile: Profile(
                    //           name: name,
                    //           businessName: businessName,
                    //           gender: gender,
                    //           avatar: "${ImageAssets.userProfile}$userImageKey",
                    //           longitude: userLocation.longitude.toString(),
                    //           latitude: userLocation.latitude.toString(),
                    //         ),
                    //       ).editProfile(ref, context)
                    //     : null;

                    final selectedImageFile = ref.watch(
                        profileController.select((value) => value?.avatarFile));
                    final updatedProfile = Profile(
                      name: name,
                      phone: _phoneController.text,
                      businessName: businessName,
                      longitude: userLocation.longitude.toString(),
                      latitude: userLocation.latitude.toString(),
                    );

                    // Call the controller method with the updated profile
                    context.mounted
                        ? ref.read(profileController.notifier).updateProfile(
                            context: context,
                            ref: ref,
                            profile: updatedProfile,
                            file: selectedImageFile)
                        : null;

                    // Show a success message or handle failure
                    context.mounted
                        ? ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Profile saved successfully!')),
                          )
                        : null;
                  },
                  child: const Text(
                    'Complete Profile',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
