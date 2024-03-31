import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/deals/deals_provider.dart';
import 'package:observatory/deals/deals_state.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/ui/dot_separator.dart';
import 'package:observatory/shared/ui/info_app_bar.dart';

class DealsInfoAppBar extends ConsumerWidget {
  final AutoDisposeFamilyAsyncNotifierProvider<AsyncDealsNotifier, DealsState,
      DealCategory> provider;

  const DealsInfoAppBar({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InfoAppBar(
      child: ref.watch(provider).when(
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
                        color: context.colors.scheme.outline,
                      ),
                      TextSpan(
                        children: [
                          TextSpan(
                            text: state.deals.length.toString(),
                            style: const TextStyle(
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
                        color: context.colors.scheme.outline,
                      ),
                      TextSpan(
                        children: [
                          TextSpan(
                            text: discounted.toString(),
                            style: const TextStyle(
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
