import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:observatory/itad_filters/providers/itad_filters_provider.dart';

const List<(int, String, IconData)> platforms = <(int, String, IconData)>[
  (1, 'Windows', FontAwesomeIcons.windows),
  (2, 'Mac', FontAwesomeIcons.apple),
  (3, 'Linux', FontAwesomeIcons.linux),
];
final List<int> defaultPlatforms = platforms.map((e) => e.$1).toList();

class PlatformSelectTile extends ConsumerWidget {
  const PlatformSelectTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<int> selectedPlatforms = ref.watch(
          itadFiltersProvider.select((value) => value.cached.platform),
        ) ??
        defaultPlatforms;

    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          title: Text(
            'Platforms',
            style: context.textStyles.titleMedium.copyWith(
              color: context.colors.scheme.onSurface,
            ),
          ),
        ),
        SegmentedButton<int>(
          expandedInsets: const EdgeInsets.symmetric(horizontal: 16.0),
          multiSelectionEnabled: true,
          emptySelectionAllowed: false,
          showSelectedIcon: false,
          selected: Set.of(
            selectedPlatforms.isEmpty ? defaultPlatforms : selectedPlatforms,
          ),
          onSelectionChanged: (Set<int> newSelection) {
            ref
                .read(itadFiltersProvider.notifier)
                .setPlatforms(newSelection.toList());
          },
          segments: platforms.map<ButtonSegment<int>>(
            ((int, String, IconData) platform) {
              return ButtonSegment<int>(
                icon: FaIcon(
                  platform.$3,
                  color: selectedPlatforms.contains(platform.$1)
                      ? context.colors.scheme.onPrimary
                      : context.colors.scheme.primary,
                ),
                value: platform.$1,
                label: Text(platform.$2),
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
