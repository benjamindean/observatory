import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:observatory/settings/purchase/products_list.dart';
import 'package:observatory/settings/purchase/purchase_provider.dart';
import 'package:observatory/settings/purchase/purchase_state.dart';
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
      data: (state) {
        if (state.products.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ListHeading(title: 'Observatory+'),
            const ListTile(
              subtitle: Text(
                'This app is free and ad-free, and I intend to keep it that way for the foreseeable future. If you enjoy the app, please consider supporting it. Any amount is appreciated. Please note that there are no additional features or benefits for supporters.',
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(
                16.0,
                8.0,
                16.0,
                8.0,
              ),
              child: ProductsList(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextButton.icon(
                onPressed: () async {
                  ObservatorySnackBar.show(
                    context,
                    content: const Text('Restoring purchases...'),
                  );

                  await ref
                      .watch(asyncPurchaseProvider.notifier)
                      .restore()
                      .then(
                    (value) {
                      if (value) {
                        ObservatorySnackBar.show(
                          context,
                          content: const Text('Purchases restored!'),
                        );
                      } else {
                        ObservatorySnackBar.show(
                          context,
                          content: const Text('No purchases to restore.'),
                        );
                      }
                    },
                  );
                },
                label: Text(
                  'Restore Purchases',
                  style: context.textStyles.labelMedium.copyWith(
                    color: context.colors.scheme.primary,
                  ),
                ),
                icon: Icon(
                  FontAwesomeIcons.arrowsRotate,
                  color: context.colors.scheme.primary,
                  size: 16.0,
                ),
              ),
            )
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
