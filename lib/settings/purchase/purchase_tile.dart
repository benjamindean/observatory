import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:logger/logger.dart';
import 'package:observatory/settings/purchase/purchase_provider.dart';
import 'package:observatory/settings/purchase/purchase_state.dart';
import 'package:observatory/shared/ui/observatory_shimmer.dart';
import 'package:observatory/shared/ui/observatory_snack_bar.dart';
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

    return purchases.when(
      data: (data) {
        if (data.products.isEmpty) {
          return const SizedBox.shrink();
        }

        if (PurchaseStatus.pending == data.status) {
          return const ObservatoryShimmer();
        }

        if (PurchaseStatus.purchased == data.status) {
          ObservatorySnackBar.show(
            context,
            content: const Text('Thank you for your support!'),
            icon: FontAwesomeIcons.solidHeart,
          );
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
                      (e) => FilledButton(
                        onPressed: PurchaseStatus.pending == data.status
                            ? null
                            : () {
                                ref
                                    .watch(asyncPurchaseProvider.notifier)
                                    .purchase(e);
                              },
                        child: Text(
                          e.price,
                          style: context.themes.text.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: PurchaseStatus.pending == data.status
                                ? context.colors.disabled
                                : context.colors.scheme.onPrimary,
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

        FirebaseCrashlytics.instance.recordError(
          error,
          stackTrace,
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
    );
  }
}
