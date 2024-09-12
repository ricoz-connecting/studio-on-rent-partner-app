import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/src/feature/Home/views/widgets/custom_search_bar.dart';
import 'package:studio_partner_app/src/feature/Home/views/widgets/saved_studio_card.dart';

class SavedStudios extends ConsumerWidget {
  const SavedStudios({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomSearchBar(
        label: 'Search saved properties',
        context: context,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            StudioCard(),
            StudioCard(),
            StudioCard(),
            StudioCard(),
          ],
        ),
      ),
    );
  }
}