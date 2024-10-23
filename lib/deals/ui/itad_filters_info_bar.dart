import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:observatory/deals/providers/deals_provider.dart';
import 'package:observatory/itad_filters/itad_filters_page.dart';
import 'package:observatory/itad_filters/providers/itad_filters_provider.dart';
import 'package:observatory/settings/providers/itad_config_provider.dart';
import 'package:observatory/shared/models/itad_filters.dart';
import 'package:observatory/shared/ui/dot_separator.dart';

class ITADFiltersInfoBar extends ConsumerWidget {
  const ITADFiltersInfoBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ITADFilters filters = ref.watch(
      itadFiltersProvider.select((value) => value.current),
    );
    final String currency = ref.watch(
      itadConfigProvider.select(
        (value) => value.valueOrNull?.currency ?? 'USD',
      ),
    );

    if (filters == const ITADFilters()) {
      return const SizedBox.shrink();
    }

    final List<String> tags = filters.tags ?? [];

    return GestureDetector(
      onTap: () => showITADFilters(context),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.colors.scheme.surfaceContainer,
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          child: ListTile(
            dense: true,
            contentPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 8.0, 0.0),
            leading: Icon(
              Icons.filter_list_sharp,
              color: context.colors.scheme.onSurfaceVariant,
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.cancel,
                color: context.colors.scheme.onSurfaceVariant,
              ),
              onPressed: filters != const ITADFilters()
                  ? () {
                      ref.read(itadFiltersProvider.notifier).reset();
                      ref
                          .read(asyncDealsProvider.notifier)
                          .reset(withLoading: true);
                    }
                  : null,
            ),
            title: Text(
              tags.isNotEmpty ? tags.join(', ') : 'All Tags',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textStyles.labelLarge.copyWith(
                color: context.colors.scheme.onSurfaceVariant,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text.rich(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.themes.text.labelMedium?.copyWith(
                color: context.colors.hint,
                letterSpacing: 0.1,
              ),
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Price:',
                  ),
                  WidgetSpan(
                    child: Visibility(
                      visible: filters.price != null,
                      child: Icon(
                        Icons.keyboard_arrow_left_rounded,
                        size: 14,
                        color: context.colors.scheme.onSurfaceVariant,
                      ),
                    ),
                    alignment: PlaceholderAlignment.middle,
                  ),
                  TextSpan(
                    text: filters.price != null
                        ? NumberFormat.simpleCurrency(
                            name: currency,
                            decimalDigits: 0,
                          ).format(filters.price?.max)
                        : ' Any',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DotSeparator.textSpan(context),
                  const TextSpan(
                    text: 'Discount:',
                  ),
                  WidgetSpan(
                    child: Visibility(
                      visible: filters.cut != null,
                      child: Icon(
                        Icons.keyboard_arrow_right_rounded,
                        size: 14,
                        color: context.colors.scheme.onSurfaceVariant,
                      ),
                    ),
                    alignment: PlaceholderAlignment.middle,
                  ),
                  TextSpan(
                    text: filters.cut != null
                        ? '${filters.cut?.min.toString()}%'
                        : ' Any',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DotSeparator.textSpan(context),
                  const TextSpan(
                    text: 'NSFW: ',
                  ),
                  TextSpan(
                    text: (filters.mature) ? 'On' : 'Off',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
