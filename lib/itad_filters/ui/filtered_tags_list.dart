import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:observatory/itad_filters/providers/itad_filters_provider.dart';
import 'package:observatory/shared/widgets/error_message.dart';

class FilteredTagsList extends ConsumerWidget {
  const FilteredTagsList({
    super.key,
    required this.filteredTags,
    required this.autocompleteController,
  });

  final List<String> filteredTags;
  final TextEditingController autocompleteController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (filteredTags.isEmpty) {
      const Center(
        child: ErrorMessage(
          message: 'No tags found for your query.',
          icon: FontAwesomeIcons.solidFaceAngry,
        ),
      );
    }

    final List<String> tags = ref.watch(
          itadFiltersProvider.select((value) => value.cached.tags),
        ) ??
        [];

    return ListView.builder(
      itemCount: filteredTags.length,
      itemBuilder: (context, index) {
        final bool isSelected = tags.contains(
          filteredTags[index],
        );

        return CheckboxListTile(
          secondary:
              index == 0 ? const Icon(Icons.keyboard_return_rounded) : null,
          controlAffinity: ListTileControlAffinity.leading,
          selectedTileColor: context.colors.scheme.secondaryContainer,
          value: isSelected,
          title: Text(filteredTags[index]),
          onChanged: (value) async {
            if (value == false) {
              ref
                  .watch(itadFiltersProvider.notifier)
                  .removeTag(filteredTags[index]);
            } else {
              ref
                  .watch(itadFiltersProvider.notifier)
                  .addTags([filteredTags[index]]);
            }

            autocompleteController.clear();
          },
        );
      },
    );
  }
}
