import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rive/rive.dart';
import 'package:studio_partner_app/src/commons/globals/register_dict.dart';
import 'package:studio_partner_app/src/res/assets.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_extension_methods.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_text_field.dart';

// ignore: must_be_immutable
class Register4 extends StatefulWidget {
   Register4({super.key, required this.textEditingController,this.backs,this.front});
  final TextEditingController textEditingController ;
Uint8List? front;
  Uint8List? backs;
  @override
  State<Register4> createState() => _Register4State();
}

class _Register4State extends State<Register4> {
  
  
  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(25),
          child: Text('Upload documents for verification'),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: DropdownButtonFormField(
              dropdownColor: color.surface,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: color.onSecondary,
                      ),
                      borderRadius: BorderRadius.circular(15))),
              hint: const Row(
                children: [Icon(Icons.edit_document), Text("Select document")],
              ),
              items: const [
                DropdownMenuItem(
                  value: 'AdhaarCard',
                  child: Text('Adhaar Card'),
                ),
                DropdownMenuItem(
                  value: 'PANCard',
                  child: Text('PAN Card'),
                ),
              ],
              onChanged: (val) {
                log(val.toString());
                registerDict
                    .addAll({"documentType": val} as Map<String, dynamic>);
              }),
        ),
        CustomTextField(
            validator: (val) {
              if (val!.isEmpty) {
                return 'Document No. can\'t be empty';
              }
              registerDict.addAll({
                "documentNumber": val.trim(),
              } as Map<String, dynamic>);
              return null;
            },
            hintText: 'Document No.',
            controller: widget.textEditingController,
            icon: const Icon(Icons.edit_document)),
        Row(
          children: [
            Container(
                    margin: widget.front != null ? EdgeInsets.all(9) : null,
                    height: widget.front != null ? 100 : null,
                    width: widget.front != null ? 100 : null,
                    decoration: widget.front != null
                        ? BoxDecoration(
                            image: DecorationImage(
                                image: MemoryImage(widget.front!), fit: BoxFit.cover))
                        : null,
                    child: widget.front != null
                        ? null
                        : CustomImagePick(color: color, type: 'front'))
                .onTap(() async {
              final file =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (file != null) {
                final image = await file.readAsBytes();
                setState(() {
                  widget.front = image;
                });
                registerDict
                    .addAll({"documentFront": image} as Map<String, dynamic>);
              }
            }),
            Container(
                    margin: widget.backs != null ? EdgeInsets.all(9) : null,
                    height: widget.backs != null ? 100 : null,
                    width: widget.backs != null ? 100 : null,
                    decoration:widget. backs != null
                        ? BoxDecoration(
                            image: DecorationImage(
                                image: MemoryImage(widget.backs!), fit: BoxFit.cover))
                        : null,
                    child: widget.backs != null
                        ? null
                        : CustomImagePick(color: color, type: 'back'))
                .onTap(() async {
              final file =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (file != null) {
                final image = await file.readAsBytes();
                setState(() {
                  widget.backs = image;
                });
                registerDict
                    .addAll({"documentFront": image} as Map<String, dynamic>);
              }
            })
          ],
        )
      ],
    );
  }
}

class CustomImagePick extends StatelessWidget {
  const CustomImagePick({
    super.key,
    required this.color,
    required this.type,
  });

  final ColorScheme color;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 22, top: 22),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: color.onSecondary),
                borderRadius: BorderRadius.circular(15)),
            height: 100,
            width: 100,
            child: ImageIcon(
              const AssetImage(ImageAssets.addimage),
              color: color.onSecondary,
            ),
          ),
          Text(type),
        ],
      ),
    );
  }
}
