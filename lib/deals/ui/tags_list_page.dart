import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:observatory/deals/itad_filters_provider.dart';
import 'package:observatory/shared/models/itad_filters.dart';
import 'package:observatory/shared/steam_tags_listdart.dart';

class TagsListPage extends ConsumerWidget {
  const TagsListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ITADFilters filters = ref.watch(
      itadFiltersProvider,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Genres & Tags'),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: steamTags.length,
          itemBuilder: (context, index) {
            return ListTile(
              selected: filters.tags?.contains(steamTags[index]) ?? false,
              title: Text(steamTags[index]),
              onTap: () {
                ref.watch(itadFiltersProvider.notifier).update(
                      filters.copyWith(
                        tags: [steamTags[index]],
                      ),
                    );
                context.pop();
              },
            );
          },
        ),
      ),
    );
  }
}
