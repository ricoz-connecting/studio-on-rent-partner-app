import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_partner_app/src/features/home/presentation/bloc/store_bloc/store_bloc.dart';
import 'package:studio_partner_app/src/features/stores/domain/entity/studio_entity.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_error_box.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_extension_methods.dart';
import 'package:studio_partner_app/src/utils/widgets/item_list_tile.dart';

class StoresPage extends StatefulWidget {
  const StoresPage({super.key});

  @override
  State<StoresPage> createState() => _StoresPageState();
}

class _StoresPageState extends State<StoresPage> {
  List<String> categories = ["All", "verified", "pending"];
  List<StudioEntity> verified = [];
  List<StudioEntity> pending = [];
  List<StudioEntity> all = [];

  int selectedCategoryIndex = 0;
  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.only(bottom: 10),
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
                        color: selectedCategoryIndex == index
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
                      selectedCategoryIndex = index;
                    });
                  })),
        ),
        Expanded(
          child: BlocConsumer<StoreBloc, StoreState>(
            listener: (context, state) {
              if (state is StoreFailureState) {
                showErrorBox(context, state.message, () {
                  context.pop();
                });
              }
            },
            builder: (context, state) {
              if (state is StoreSuccessState) {
                if (state.studios.isEmpty) {
                  return const Center(
                    child: Text("No Data To Show"),
                  );
                }
                return ListView.builder(
                    itemCount: state.studios.length,
                    itemBuilder: (context, index) {
                      return state.studios[index].status ==
                              categories[selectedCategoryIndex]
                          ? ItemListTile(studioEntity: state.studios[index])
                          : selectedCategoryIndex == 0
                              ? ItemListTile(studioEntity: state.studios[index])
                              :const SizedBox();
                    });
              } else if (state is StoreLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is StoreFailureState) {
                return const Center(
                  child: Text("Error"),
                );
              } else {
                return const SizedBox(
                  child: Text("kyu"),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
