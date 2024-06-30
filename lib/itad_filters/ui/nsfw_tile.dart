import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/itad_filters/providers/itad_filters_provider.dart';

class NSFWTile extends ConsumerWidget {
  const NSFWTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isEnabled = ref.watch(
      itadFiltersProvider.select((value) => value.cached.mature),
    );

    return SwitchListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      title: Text(
        'NSFW Content',
        style: context.textStyles.titleMedium.copyWith(
          color: context.colors.scheme.onSurface,
        ),
      ),
      subtitle: Text(
        'Show games with mature content',
        style: context.textStyles.bodySmall.copyWith(
          color: context.colors.scheme.onSurface,
        ),
      ),
      value: isEnabled,
      onChanged: (value) {
        ref.watch(itadFiltersProvider.notifier).setNSFW(value);
      },
    );
  }
}
