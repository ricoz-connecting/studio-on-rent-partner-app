import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rive/rive.dart';
import 'package:studio_partner_app/src/commons/views/widgets/simple_app_bar.dart';
import 'package:studio_partner_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:studio_partner_app/src/res/assets.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_extension_methods.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_text_button.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_text_field.dart';
import 'package:studio_partner_app/src/utils/widgets/form_text_field.dart';

class EditProfileInfoView extends StatefulWidget {
  static String routePath = '/edit-profile-info';

  const EditProfileInfoView({super.key});

  @override
  State<EditProfileInfoView> createState() => _EditProfileInfoViewState();
}

class _EditProfileInfoViewState extends State<EditProfileInfoView> {
  // UpdateParams updateParams = UpdateParams();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController =
      TextEditingController(text: 'user.phoneNumber');
  final TextEditingController emailController =
      TextEditingController(text: 'user.email');
  Uint8List? pickedImage;

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: SimpleAppBar(
        bgColor: color.secondary,
        title: "Edit Profile",
        centerTitle: false,
      ),
      backgroundColor: color.surface,
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _profilePickBuilder(context),
                    _buildFormFields(context),
                  ],
                ),
              ),
            ),
            //
            Container(
              child: CustomTextButton(
                  borderRadius: 10,
                  text: "Save",
                  ontap: () {
                    // final updateParams = UpdateParams(
                    //   photoUrl: pickedImage,
                    //     gender: user.gender,
                    //     name: nameController.text.trim(),
                    //     email: emailController.text.trim(),
                    //     phoneNumber: phoneController.text.trim());
                  }),
            )
          ],
        ),
      ),
    );
  }

  _buildFormFields(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Container(
        decoration: BoxDecoration(
            color: color.secondary, borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                "Restaurant/Business name",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            CustomTextField(
              left: 10,
              right: 10,
              validator: (validator) {},
              hintText: "ABC XYZ Restaurant",
              controller: emailController,
              icon: Icon(Icons.restaurant),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                "Address",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            CustomTextField(
              left: 10,
              right: 10,
              validator: (validator) {},
              hintText: "ABC XYZ Place",
              controller: emailController,
              icon: Icon(Icons.house),
            ),
            CustomTextField(
              left: 10,
              right: 10,
              validator: (validator) {},
              hintText: "City",
              controller: emailController,
              icon: Icon(Icons.house),
            ),
            CustomTextField(
              left: 10,
              right: 10,
              validator: (validator) {},
              hintText: "State",
              controller: emailController,
              icon: Icon(Icons.house),
            ),
            // button
          ],
        ));
  }

  _pickImage() async {
    XFile? img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      final _pickedImage = await File(img.path).readAsBytes();

      setState(() {
        pickedImage = _pickedImage;
      });
    }
  }

  _profilePickBuilder(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
      decoration: BoxDecoration(
          color: color.secondary, borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              _pickImage();
            },
            child: CircleAvatar(
              radius: 50,
              backgroundColor: color.tertiary,
              // backgroundImage: MemoryImage(),
              child: Center(
                child: ImageIcon(
                  AssetImage(ImageAssets.editIcon),
                  color: color.secondary,
                ),
              ),
            ),
          ),
          CustomTextField(
              icon: Transform.scale(
                  child: SvgPicture.asset(
                    ImageAssets.user1,
                    color: color.tertiary,
                  ),
                  scale: 0.5),
              validator: (Va) {},
              hintText: "John Doe",
              controller: emailController),
          CustomTextField(
              icon: Icon(
                Icons.call,
                color: color.tertiary,
              ),
              validator: (Va) {},
              hintText: "John Doe",
              controller: emailController)
        ],
      ),
    );
  }
}
