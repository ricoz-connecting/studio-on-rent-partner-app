import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studio_partner_app/src/commons/globals/register_dict.dart';
import 'package:studio_partner_app/src/features/register/presentation/tabs/register_4.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_extension_methods.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_text_field.dart';

class Register5 extends StatefulWidget {
  Register5(
      {super.key,
      this.firstImage,
      required this.aboutEditingController,
      required this.qrDataEditingController});

  final TextEditingController aboutEditingController;
  final TextEditingController qrDataEditingController;
  Uint8List? firstImage;
  @override
  State<Register5> createState() => _Register5State();
}

class _Register5State extends State<Register5> {
  int numberOfPhotos = 0;
  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Column(
      children: [
        CustomTextField(
            onchanged: (val) {
              if (val.isNotEmpty) {
                registerDict.addAll({'description': val.trim()});
              }
            },
            minlines: 5,
            validator: (val) {
              return null;
            },
            hintText: "Tell us about yourself",
            controller: widget.aboutEditingController),
        CustomTextField(
            onchanged: (val) {
              if (val.isNotEmpty) {
                log(val);
                registerDict.addAll({'qrData': val.trim()});
              }
            },
            length: 50,
            validator: (val) {
              return null;
            },
            hintText: "QR Data, Ex. website name,email,address",
            controller: widget.qrDataEditingController),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: widget.firstImage != null ? EdgeInsets.all(22) : null,
            height: widget.firstImage != null ? 100 : null,
            width: widget.firstImage != null ? 100 : null,
            decoration: widget.firstImage != null
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: MemoryImage(widget.firstImage!),
                        fit: BoxFit.cover))
                : null,
            child: widget.firstImage != null
                ? Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(blurStyle: BlurStyle.inner, blurRadius: 300)
                        ]),
                    child: Center(
                      child: Text(
                        numberOfPhotos.toString(),
                        style: TextStyle(fontSize: 30, color: color.secondary),
                      ),
                    ),
                  )
                : CustomImagePick(
                    color: color,
                    type: "Media",
                  ),
          ).onTap(() async {
            final medias = await ImagePicker()
                .pickMultiImage(requestFullMetadata: false, limit: 30);
            if (medias.isNotEmpty) {
              final listofmediaBytes = await Future.wait(
                  medias.map((e) async => await e.readAsBytes()).toList());
              registerDict.addAll({"media": listofmediaBytes});
              widget.firstImage = listofmediaBytes.first;
              numberOfPhotos = medias.length;
              setState(() {});
            }
          }),
        ),
      ],
    );
  }
}
