import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/search/search_provider.dart';
import 'package:observatory/search/search_state.dart';
import 'package:observatory/shared/ui/dot_separator.dart';
import 'package:observatory/shared/ui/info_app_bar.dart';
import 'package:observatory/waitlist/waitlist_provider.dart';

class WaitlistInfoAppBar extends ConsumerWidget {
  const WaitlistInfoAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SearchState searchState = ref.watch(filterResultsProvider);

    if (searchState.isOpen) {
      return const SliverToBoxAdapter(
        child: SizedBox.shrink(),
      );
    }

    return InfoAppBar(
      child: ref.watch(asyncWaitListProvider).when(
            data: (state) {
              final int discounted = state.deals
                  .where((element) => element.bestPrice.cut > 0)
                  .length;

              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text.rich(
                      style: context.themes.text.labelLarge?.copyWith(
                        color: context.colors.hint,
                      ),
                      TextSpan(
                        children: [
                          TextSpan(
                            text: state.deals.length.toString(),
                            style: context.themes.text.labelLarge?.copyWith(
                              color: context.colors.hint,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(text: ' games'),
                        ],
                      ),
                    ),
                    const DotSeparator(),
                    Text.rich(
                      style: context.themes.text.labelLarge?.copyWith(
                        color: context.colors.hint,
                      ),
                      TextSpan(
                        children: [
                          TextSpan(
                            text: discounted.toString(),
                            style: context.themes.text.labelLarge?.copyWith(
                              color: context.colors.hint,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(text: ' discounted'),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (error, stackTrace) => const SizedBox.shrink(),
          ),
    );
  }
}
