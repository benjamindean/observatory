import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:logger/logger.dart';
import 'package:observatory/settings/purchase/purchase_provider.dart';
import 'package:observatory/settings/purchase/purchase_state.dart';
import 'package:observatory/shared/widgets/list_heading.dart';

class PurchaseTile extends ConsumerWidget {
  const PurchaseTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<PurchaseState> purchases = ref.watch(
      asyncPurchaseProvider,
    );

    return Container(
      child: purchases.when(
        data: (data) {
          if (data.products.isEmpty) {
            return const SizedBox.shrink();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ListHeading(title: 'Support the app'),
              const ListTile(
                subtitle: Text(
                  'This app is free and ad-free, and I intend to keep it that way for the foreseeable future. If you enjoy the app, please consider supporting it. Any amount is appreciated. Please note that there are no additional features or benefits for supporters.',
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  16.0,
                  8.0,
                  16.0,
                  8.0,
                ),
                child: Wrap(
                  spacing: 12.0,
                  children: data.products
                      .map(
                        (e) => OutlinedButton(
                          onPressed: data.status != PurchaseStatus.canceled
                              ? () {
                                  ref
                                      .watch(asyncPurchaseProvider.notifier)
                                      .purchase(e);
                                }
                              : null,
                          child: Text(
                            e.price,
                            style: context.themes.text.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: context.colors.scheme.onBackground,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          );
        },
        error: (error, stackTrace) {
          Logger().e(
            'Failed to load purchases',
            error: error,
            stackTrace: stackTrace,
          );

          return const SizedBox.shrink();
        },
        loading: () {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: LinearProgressIndicator(
              borderRadius: BorderRadius.circular(12.0),
              minHeight: 2,
              color: context.colors.scheme.onSurfaceVariant,
            ),
          );
        },
      ),
    );
  }
}
