import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:observatory/deal/providers/overview_provider.dart';
import 'package:observatory/deal/ui/page_sections/bundles_bottom_sheet.dart';
import 'package:observatory/deal/ui/page_sections/deal_page_section_async.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/models/overview.dart';

class BundlesTile extends ConsumerWidget {
  final Deal deal;

  const BundlesTile({
    super.key,
    required this.deal,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Overview?> overviewState = ref.watch(
      overviewProvider(deal.id),
    );
    final bool isEnabled =
        overviewState.valueOrNull?.bundles?.isNotEmpty ?? false;
    final List<Bundle>? bundles = overviewState.valueOrNull?.bundles;

    return InkWell(
      onTap: isEnabled
          ? () => showBundlesBottomSheet(context, bundles ?? [])
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: DealPageSectionAsync(
              state: overviewState,
              deal: deal,
              onData: (overview) {
                if (bundles == null || bundles.isEmpty) {
                  return Text(
                    'This game is not currently a part of any bundle.',
                    style: context.themes.text.labelLarge?.copyWith(
                      color: context.colors.disabled,
                    ),
                  );
                }

                return Text(
                  '${bundles.length} ${Intl.plural(bundles.length, one: 'bundle', other: 'bundles')} currently available!',
                  style: context.themes.text.labelLarge?.copyWith(
                    color: context.colors.scheme.onSurface,
                  ),
                );
              },
              heading: 'Bundles',
            ),
          ),
          if (isEnabled)
            Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: Icon(
                Icons.keyboard_arrow_up_rounded,
                color: context.colors.scheme.onSurfaceVariant,
              ),
            )
        ],
      ),
    );
  }
}
