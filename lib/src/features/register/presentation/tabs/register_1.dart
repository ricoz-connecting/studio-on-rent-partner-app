import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/res/assets.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_text_field.dart';

class Register1 extends StatelessWidget {
  final TextEditingController textEditingController = TextEditingController();
  Register1({super.key});

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
              color: color.secondary,
              shape: BoxShape.circle,
              image: const DecorationImage(
                  colorFilter: ColorFilter.srgbToLinearGamma(),
                  image: AssetImage(
                    ImageAssets.profileImageJpeg,
                  ))),
          child: Center(
            child: IconButton(
              icon: ImageIcon(
                const AssetImage(ImageAssets.editIcon),
                color: color.onPrimary,
              ),
              onPressed: () {},
            ),
          ),
        ),
        CustomTextField(
          icon:const Icon(Icons.person_outline_sharp),
          controller: textEditingController,
          hintText: 'Enter your name',
          validator: (val) {
            return null;
          },
        )
      ],
    );
  }
}
