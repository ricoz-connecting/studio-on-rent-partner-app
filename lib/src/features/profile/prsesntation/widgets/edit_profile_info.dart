import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studio_partner_app/src/commons/globals/agent_details.dart';
import 'package:studio_partner_app/src/commons/params/update_params.dart';
import 'package:studio_partner_app/src/commons/views/widgets/simple_app_bar.dart';
import 'package:studio_partner_app/src/features/profile/prsesntation/bloc/update_bloc/update_bloc.dart';
import 'package:studio_partner_app/src/res/assets.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_error_box.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_text_button.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_text_field.dart';

class EditProfileInfoView extends StatefulWidget {
  static String routePath = '/edit-profile-info';

  const EditProfileInfoView({super.key});

  @override
  State<EditProfileInfoView> createState() => _EditProfileInfoViewState();
}

class _EditProfileInfoViewState extends State<EditProfileInfoView> {
  // UpdateParams updateParams = UpdateParams();
  final TextEditingController nameController =
      TextEditingController(text: globalAgentModel!.name);
  final TextEditingController phoneController =
      TextEditingController(text: globalAgentModel!.phoneNumber);
  final TextEditingController emailController =
      TextEditingController(text: globalAgentModel!.email);
  final TextEditingController addressController =
      TextEditingController(text: globalAgentModel!.address);
  final TextEditingController businessaController = TextEditingController(
      text: globalAgentModel!.businessname ?? 'Not Provided');
  final TextEditingController stateController =
      TextEditingController(text: globalAgentModel!.state);
  final TextEditingController cityController =
      TextEditingController(text: globalAgentModel!.city);
  final TextEditingController pincodeController =
      TextEditingController(text: globalAgentModel!.pincode);
  final TextEditingController serviceController = TextEditingController(
      text: globalAgentModel!.service
          .toString()
          .replaceAll('[', '')
          .replaceAll(']', ''));
  late Uint8List pickedImage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pickedImage = globalAgentModel!.photoUrl;
  }

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
        child: BlocConsumer<UpdateBloc, UpdateState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is UpdateFailureState) {
              showErrorBox(context, state.message, () {
                context.pop();
              });
            } else if (state is UpdateSuccessState) {
              showErrorBox(context, "Successfully Updated", () {
                context.pop();
              });
            }
          },
          builder: (context, state) {
            if (state is UpdateLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
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
                  CustomTextButton(
                      borderRadius: 10,
                      text: "Save",
                      ontap: () {
                        final updateParams = AgentUpdateParams(
                            name: nameController.text.trim(),
                            businessname: businessaController.text.trim(),
                            address: addressController.text.trim(),
                            city: cityController.text.trim(),
                            pincode: pincodeController.text.trim(),
                            state: stateController.text.trim(),
                            service: serviceController.text.split(','),
                            photoUrl: pickedImage);

                        context.read<UpdateBloc>().add(
                            UpdateAgentEvent(agentUpdateParams: updateParams));
                      })
                ],
              );
            }
          },
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
            const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                "Restaurant/Business name",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            CustomTextField(
              left: 10,
              right: 10,
              validator: (validator) {
                return null;
              },
              hintText: "ABC XYZ Restaurant",
              controller: emailController,
              icon: const Icon(Icons.restaurant),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                "Address",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            CustomTextField(
              left: 10,
              right: 10,
              validator: (validator) {
                return null;
              },
              hintText: "ABC XYZ Place",
              controller: addressController,
              icon: const Icon(Icons.house),
            ),
            CustomTextField(
              left: 10,
              right: 10,
              validator: (validator) {
                return null;
              },
              hintText: "City",
              controller: stateController,
              icon: const Icon(Icons.house),
            ),
            CustomTextField(
              left: 10,
              right: 10,
              validator: (validator) {
                return null;
              },
              hintText: "State",
              controller: cityController,
              icon: const Icon(Icons.house),
            ),
            CustomTextField(
              left: 10,
              right: 10,
              validator: (validator) {
                return null;
              },
              hintText: "pincode",
              controller: pincodeController,
              icon: const Icon(Icons.house),
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
        globalAgentModel!.copyWith(photoUrl: _pickedImage);
      });
    }
  }

  _profilePickBuilder(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
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
              backgroundImage: MemoryImage(pickedImage),
              child: Center(
                child: ImageIcon(
                  const AssetImage(ImageAssets.editIcon),
                  color: color.secondary,
                ),
              ),
            ),
          ),
          CustomTextField(
              icon: Transform.scale(
                  scale: 0.5,
                  child: SvgPicture.asset(
                    ImageAssets.user1,
                    color: color.tertiary,
                  )),
              validator: (val) {
                return null;
              },
              hintText: "John Doe",
              controller: nameController),
          CustomTextField(
              enable: false,
              icon: Icon(
                Icons.call,
                color: color.tertiary,
              ),
              validator: (val) {
                return null;
              },
              hintText: "John Doe",
              controller: phoneController),
          CustomTextField(
              enable: false,
              icon: Icon(
                Icons.call,
                color: color.tertiary,
              ),
              validator: (val) {
                return null;
              },
              hintText: "John Doe",
              controller: emailController),
          CustomTextField(
              validator: (validator) {
                return null;
              },
              hintText: 'services',
              controller: serviceController)
        ],
      ),
    );
  }
}
