import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:studio_partner_app/src/res/assets.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_extension_methods.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_text_field.dart';

class Register4 extends StatefulWidget {
  const Register4({super.key});

  @override
  State<Register4> createState() => _Register4State();
}

class _Register4State extends State<Register4> {
  TextEditingController textEditingController = TextEditingController();
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
                  value: 'adhaar',
                  child: Text('Adhaar Card'),
                ),
                DropdownMenuItem(
                  value: 'pan',
                  child: Text('PAN Card'),
                ),
              ],
              onChanged: (val) {}),
        ),
        CustomTextField(
            validator: (val) => null,
            hintText: 'Document No.',
            controller: textEditingController,
            icon: const Icon(Icons.edit_document)),
        Row(
          children: [
            CustomImagePick(color: color, type: 'front'),
            CustomImagePick(color: color, type: 'back')
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
