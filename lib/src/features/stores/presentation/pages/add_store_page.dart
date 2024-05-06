import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/commons/views/widgets/simple_app_bar.dart';
import 'package:studio_partner_app/src/features/register/presentation/tabs/register_4.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_extension_methods.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_text_button.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_text_field.dart';

class AddStorePage extends StatefulWidget {
  static const routePath = '/add-store-page';
  const AddStorePage({super.key});

  @override
  State<AddStorePage> createState() => _AddStorePageState();
}

class _AddStorePageState extends State<AddStorePage> {
  List<String> categories = ["photography", "Music"];
  List<String> selectedCategories = [];
  TextEditingController _controller = TextEditingController();
  int sealectedCategoryIndex = 0;
  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: SimpleAppBar(
        bgColor: color.secondary,
        title: "Add Studio Request",
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              validator: (validator) {
                return null;
              },
              hintText: 'Studio Name *',
              controller: _controller,
            ),
            CustomTextField(
              validator: (validator) {
                return null;
              },
              hintText: 'Price *',
              controller: _controller,
              icon: Icon(Icons.price_change_rounded),
            ),
            CustomTextField(
              validator: (validator) {
                return null;
              },
              hintText: 'Address *',
              controller: _controller,
              icon: Icon(Icons.house),
            ),
            Container(
              padding: EdgeInsets.only(left: 25, top: 20),
              alignment: Alignment.centerLeft,
              child: const Text(
                "Category",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10, top: 10),
              padding: EdgeInsets.only(bottom: 10),
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) => Container(
                        height: 29,
                        margin: EdgeInsets.only(left: index == 0 ? 20 : 15),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 17, vertical: 6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color:
                                  selectedCategories.contains(categories[index])
                                      ? color.primary
                                      : color.onSecondary,
                              width:
                                  selectedCategories.contains(categories[index])
                                      ? 3
                                      : 1,
                            )),
                        child: Center(
                          child: Text(
                            categories[index],
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: sealectedCategoryIndex == index
                                  ? color.primary
                                  : color.onSecondary,
                            ),
                          ),
                        ),
                      ).onTap(() {
                        setState(() {
                          if (selectedCategories.contains(categories[index])) {
                            selectedCategories.remove(categories[index]);
                          } else {
                            selectedCategories.add(categories[index]);
                          }
                        });
                      })),
            ),
            CustomTextField(
              validator: (val) {
                return null;
              },
              hintText: "About Section",
              controller: _controller,
              minlines: 3,
              maxlines: 15,
            ),
            Container(
              padding: EdgeInsets.only(left: 25, top: 20),
              alignment: Alignment.centerLeft,
              child: const Text(
                "Category",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            CustomImagePick(color: color, type: ""),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
              child: CustomTextButton(
                  borderRadius: 10,
                  text: "Post Add Studio Request",
                  ontap: () {}),
            )
          ],
        ),
      ),
    );
  }
}
