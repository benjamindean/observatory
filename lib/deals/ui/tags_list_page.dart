import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:observatory/deals/itad_filters_provider.dart';
import 'package:observatory/shared/models/itad_filters.dart';
import 'package:observatory/shared/steam_tags_list.dart';

class TagsListPage extends ConsumerStatefulWidget {
  const TagsListPage({super.key});

  @override
  TagsListPageState createState() => TagsListPageState();
}

class TagsListPageState extends ConsumerState<TagsListPage> {
  List<String> filteredTags = steamTags;
  final TextEditingController autocompleteController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ITADFilters filters = ref.watch(
      itadFiltersProvider,
    );
    final List<String> tags = filters.tags ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Genres & Tags'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: filteredTags.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    selectedTileColor: context.colors.scheme.secondaryContainer,
                    selectedColor: context.colors.scheme.onSecondaryContainer,
                    trailing: index == 0
                        ? const Icon(Icons.keyboard_return_rounded)
                        : null,
                    selected: tags.contains(filteredTags[index]),
                    title: Text(filteredTags[index]),
                    onTap: () {
                      return ref
                          .watch(itadFiltersProvider.notifier)
                          .addTags([filteredTags[index]]);
                    },
                  );
                },
              ),
            ),
            Visibility(
              visible: tags.isNotEmpty,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: context.colors.scheme.surfaceContainer,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Wrap(
                    spacing: 8.0,
                    children: filters.tags?.map(
                          (tag) {
                            return Chip(
                              side: BorderSide.none,
                              label: Text(
                                tag,
                                style: context.textStyles.labelMedium.copyWith(
                                  color: context.colors.scheme.onPrimary,
                                ),
                              ),
                              deleteIconColor: context.colors.scheme.onPrimary,
                              visualDensity: VisualDensity.compact,
                              backgroundColor: context.colors.scheme.primary,
                              onDeleted: () {
                                ref
                                    .watch(itadFiltersProvider.notifier)
                                    .removeTag(tag);
                              },
                            );
                          },
                        ).toList() ??
                        [],
                  ),
                ),
              ),
            ),
            TextField(
              autofocus: true,
              keyboardType: TextInputType.text,
              controller: autocompleteController,
              onEditingComplete: () {
                autocompleteController.clear();
              },
              onChanged: (value) => setState(() {
                filteredTags = steamTags
                    .where((tag) => tag.toLowerCase().contains(value))
                    .toList();
              }),
              onSubmitted: (_) {
                ref
                    .watch(itadFiltersProvider.notifier)
                    .addTags([filteredTags.first]);

                setState(() {
                  filteredTags = steamTags;
                });
              },
              decoration: InputDecoration(
                suffixIcon: TextButton.icon(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(Icons.check),
                  label: const Text('Done'),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.zero,
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.zero,
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.zero,
                ),
                hintText: 'Filter by name',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
