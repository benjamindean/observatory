import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:observatory/itad_filters/providers/itad_filters_provider.dart';

class TagsFilterTile extends ConsumerWidget {
  const TagsFilterTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String>? tags = ref.watch(
      itadFiltersProvider.select((value) => value.cached.tags),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          title: Text(
            'Genres & Tags',
            style: context.textStyles.titleMedium.copyWith(
              color: context.colors.scheme.onSurface,
            ),
          ),
          subtitle: const Text('Filter by specific tags'),
          trailing: TextButton.icon(
            icon: const Icon(Icons.add_rounded),
            label: const Text('Add'),
            onPressed: () {
              context.push('/tags-select');
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Wrap(
              children: tags?.map(
                    (tag) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Chip(
                          side: BorderSide.none,
                          label: Text(
                            tag,
                            style: context.textStyles.labelMedium.copyWith(
                              color: context.colors.scheme.onSecondary,
                            ),
                          ),
                          deleteIconColor: context.colors.scheme.onSecondary,
                          visualDensity: VisualDensity.compact,
                          backgroundColor: context.colors.scheme.secondary,
                          onDeleted: () {
                            ref
                                .watch(itadFiltersProvider.notifier)
                                .removeTag(tag);
                          },
                        ),
                      );
                    },
                  ).toList() ??
                  []),
        )
      ],
    );
  }
}
