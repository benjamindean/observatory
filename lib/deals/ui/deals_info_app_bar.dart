import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/deals/deals_provider.dart';
import 'package:observatory/deals/deals_state.dart';
import 'package:observatory/settings/settings_repository.dart';

class DealsInfoAppBar extends ConsumerWidget {
  final AutoDisposeFamilyAsyncNotifierProvider<AsyncDealsNotifier, DealsState,
      DealCategory> provider;

  const DealsInfoAppBar({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(provider).when(
          data: (state) {
            final int discounted = state.deals
                .where((element) => element.bestPrice.cut > 0)
                .length;

            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text.rich(
                  style: context.themes.text.labelMedium?.copyWith(
                    color: context.colors.hint,
                  ),
                  TextSpan(
                    children: [
                      TextSpan(
                        text: discounted.toString(),
                        style: context.themes.text.labelMedium?.copyWith(
                          color: context.colors.hint,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  ' of ',
                  style: context.themes.text.labelMedium?.copyWith(
                    color: context.colors.hint,
                  ),
                ),
                Text.rich(
                  style: context.themes.text.labelMedium?.copyWith(
                    color: context.colors.hint,
                  ),
                  TextSpan(
                    children: [
                      TextSpan(
                        text: state.deals.length.toString(),
                        style: context.themes.text.labelMedium?.copyWith(
                          color: context.colors.hint,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(text: ' discounted'),
                    ],
                  ),
                ),
              ],
            );
          },
          loading: () => Text(
            'Loading...',
            style: context.themes.text.labelMedium?.copyWith(
              color: context.colors.hint,
            ),
          ),
          error: (error, stackTrace) => Text(
            'No discounted games',
            style: context.themes.text.labelMedium?.copyWith(
              color: context.colors.hint,
            ),
          ),
        );
  }
}
