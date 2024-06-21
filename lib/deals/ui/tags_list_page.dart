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
  final List<String> selectedTags = [];
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
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: filteredTags.length,
                itemBuilder: (context, index) {
                  return ListTile(
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
            TextField(
              autofocus: true,
              controller: autocompleteController,
              onChanged: (value) => setState(() {
                filteredTags = steamTags
                    .where((tag) => tag.toLowerCase().contains(value))
                    .toList();
              }),
              onSubmitted: (_) {
                ref
                    .watch(itadFiltersProvider.notifier)
                    .addTags([filteredTags.first]);
              },
              decoration: InputDecoration(
                suffixIcon: TextButton.icon(
                  onPressed: () {
                    ref.watch(itadFiltersProvider.notifier).addTags(
                          selectedTags,
                        );
                    context.pop();
                  },
                  icon: const Icon(Icons.check),
                  label: const Text('Save'),
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
