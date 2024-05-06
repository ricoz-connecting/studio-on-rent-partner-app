import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/core/themes/theme.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_extension_methods.dart';
import 'package:studio_partner_app/src/utils/widgets/item_list_tile.dart';

class StoresPage extends StatefulWidget {
  const StoresPage({super.key});

  @override
  State<StoresPage> createState() => _StoresPageState();
}

class _StoresPageState extends State<StoresPage> {
  List<String> categories = ["All", "Photo", "Misc"];
  int sealectedCategoryIndex = 0;
  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.only(bottom: 10),
          color: color.secondary,
          height: 50,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) => Container(
                    height: 29,
                    margin: EdgeInsets.only(left: index == 0 ? 20 : 15),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 17, vertical: 6),
                    decoration: BoxDecoration(
                        color: sealectedCategoryIndex == index
                            ? color.primary
                            : color.surface,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        categories[index],
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: color.onSurface),
                      ),
                    ),
                  ).onTap(() {
                    setState(() {
                      sealectedCategoryIndex = index;
                    });
                  })),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: [
              ItemListTile(),
              ItemListTile(),
              ItemListTile(),
              ItemListTile()
            ].length,
            itemBuilder: (context, index) {
              final data = [
                ItemListTile(),
                ItemListTile(),
                ItemListTile(),
                ItemListTile()
              ][index];

              return data;
            },
          ),
        ),
      ],
    );
  }
}
