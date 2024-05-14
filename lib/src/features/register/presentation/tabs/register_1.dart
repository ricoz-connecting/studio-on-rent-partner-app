// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:typed_data';

import 'package:email_validator_flutter/email_validator_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:studio_partner_app/src/commons/globals/register_dict.dart';
import 'package:studio_partner_app/src/res/assets.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_text_field.dart';

// ignore: must_be_immutable
class Register1 extends StatefulWidget {
  Register1({
    super.key,
    required this.nameEditingController,
    required this.emailEditingController,
    this.image
  });
  final TextEditingController nameEditingController;

  final TextEditingController emailEditingController;
   Uint8List? image;

  @override
  State<Register1> createState() => _Register1State();
}

class _Register1State extends State<Register1> {
 
  

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(15.0),
          child: Text('Register yourself and serve more customers'),
        ),
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              color: color.onTertiary,
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.srgbToLinearGamma(),
                  image: widget.image == null
                      ? const AssetImage(
                          ImageAssets.profileImagepng,
                        )
                      : MemoryImage(widget.image!))),
          child: Center(
            child: IconButton(
              icon: ImageIcon(
                const AssetImage(ImageAssets.editIcon),
                color: color.onPrimary,
                size: 50,
              ),
              onPressed: () async {
                ImagePicker imagePicker = ImagePicker();
                final file =
                    await imagePicker.pickImage(source: ImageSource.gallery);
                log(file.toString());
                if (file != null) {
                  widget.image = await file.readAsBytes();
                  // log(image!.toString());
                  setState(() {});
                  registerDict
                      .addAll({"photoUrl": widget.image} as Map<String, dynamic>);
                }
              },
            ),
          ),
        ),
        CustomTextField(
          icon: const Icon(Icons.person_outline_sharp),
          controller: widget.nameEditingController,
          hintText: 'Enter your name',
          validator: (val) {
            if (val!.isEmpty) {
              return 'Email can\'t be empty';
            } else {
              registerDict.addAll({
                "name": widget.nameEditingController.text.trim().toString()
              } as Map<String, dynamic>);
              return null;
            }
          },
        ),
        CustomTextField(
          icon: const Icon(Icons.person_outline_sharp),
          controller: widget.emailEditingController,
          hintText: 'Enter your email',
          validator: (val) {
            EmailValidatorFlutter emailValidatorFlutter =
                EmailValidatorFlutter();

            if (val!.isEmpty) {
              return 'Email can\'t be empty';
            } else if (!emailValidatorFlutter
                .validateEmail(widget.emailEditingController.text.trim())) {
              return "INVALID EMAIL";
            } else if (widget.image == null) {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  child: Container(
                    color: color.secondary,
                    height: 300,
                    child: Center(child: Text("Please Select your Avatar")),
                  ),
                ),
              );
              return '';
            }
            registerDict.addAll({
              "email": widget.emailEditingController.text.trim().toString()
            } as Map<String, dynamic>);
            return null;
          },
        )
      ],
    );
  }
}
