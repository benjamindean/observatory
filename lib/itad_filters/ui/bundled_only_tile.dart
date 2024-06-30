import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/itad_filters/providers/itad_filters_provider.dart';

class BundledOnlyTile extends ConsumerWidget {
  const BundledOnlyTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isEnabled = ref.watch(
          itadFiltersProvider.select((value) => value.cached.bundled),
        ) ??
        false;

    return SwitchListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      title: Text(
        'Bundled Only',
        style: context.textStyles.titleMedium.copyWith(
          color: context.colors.scheme.onSurface,
        ),
      ),
      subtitle: Text(
        'Only show games that are currently bundled',
        style: context.textStyles.bodySmall.copyWith(
          color: context.colors.scheme.onSurface,
        ),
      ),
      value: isEnabled,
      onChanged: (value) {
        ref.watch(itadFiltersProvider.notifier).setBundled(value);
      },
    );
  }
}
