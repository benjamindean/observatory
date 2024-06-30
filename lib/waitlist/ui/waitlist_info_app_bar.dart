import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/search/providers/search_provider.dart';
import 'package:observatory/search/state/search_state.dart';
import 'package:observatory/waitlist/providers/waitlist_provider.dart';

class WaitlistInfoAppBar extends ConsumerWidget {
  const WaitlistInfoAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SearchState searchState = ref.watch(filterResultsProvider);

    if (searchState.isOpen) {
      return const SizedBox.shrink();
    }

    return ref.watch(asyncWaitListProvider).when(
          data: (state) {
            final int discounted = state.deals
                .where((element) => element.bestPrice.cut > 0)
                .length;

            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
            'No games in your waitlist',
            style: context.themes.text.labelMedium?.copyWith(
              color: context.colors.hint,
            ),
          ),
        );
  }
}
