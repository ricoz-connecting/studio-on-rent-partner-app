import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_partner_app/src/features/stores/domain/entity/studio_entity.dart';
import 'package:studio_partner_app/src/features/stores/presentation/pages/studio_page.dart';

class ItemListTile extends StatefulWidget {
  const ItemListTile({super.key, required this.studioEntity});
  final StudioEntity studioEntity;

  @override
  State<ItemListTile> createState() => _ItemListTileState();
}

class _ItemListTileState extends State<ItemListTile> {
  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        context
            .push(BookingView.routePath, extra: {"id": widget.studioEntity.id});
      },
      child: Container(
        decoration: BoxDecoration(
            color: widget.studioEntity.status == 'pending'
                ? Color.fromARGB(255, 250, 220, 218)
                : Color.fromARGB(255, 222, 247, 223),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: color.tertiary, offset: Offset(2, 3), blurRadius: 10)
            ]),
        padding: EdgeInsets.only(
          left: 15,
        ),
        margin: EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.studioEntity.name,
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                  Text(
                    "₹ ${widget.studioEntity.rent}/- Per day",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(widget.studioEntity.address)
                ],
              ),
            ),
            Container(
              height: 100,
              width: 100,
              // padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: MemoryImage(
                      widget.studioEntity.image,
                    ),
                    fit: BoxFit.cover),
                color: color.surface,
                borderRadius: BorderRadius.circular(10),
              ),
            )
          ],
        ),
      ),
    );
  }
}
