import 'dart:async';

import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:logger/logger.dart';
import 'package:observatory/settings/purchase/products_list.dart';
import 'package:observatory/settings/purchase/purchase_provider.dart';
import 'package:observatory/settings/purchase/purchase_state.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/ui/observatory_snack_bar.dart';
import 'package:observatory/shared/widgets/list_heading.dart';

class PurchaseTile extends ConsumerStatefulWidget {
  const PurchaseTile({super.key});

  @override
  PurchaseTileState createState() => PurchaseTileState();
}

class PurchaseTileState extends ConsumerState<PurchaseTile> {
  StreamSubscription<List<PurchaseDetails>>? _purchaseStream;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _purchaseStream?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncPurchaseNotifier notifier = ref.watch(
      asyncPurchaseProvider.notifier,
    );
    final AsyncValue<PurchaseState> purchases = ref.watch(
      asyncPurchaseProvider,
    );

    _purchaseStream = InAppPurchase.instance.purchaseStream.listen(
      (purchaseDetailsList) async {
        for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
          final PurchaseStatus status = purchaseDetails.status;

          if (status == PurchaseStatus.pending) {
            notifier.setIsPending(true);
          } else {
            if (status == PurchaseStatus.error) {
              notifier.setIsPending(false);
            } else if (status == PurchaseStatus.purchased ||
                status == PurchaseStatus.restored) {
              GetIt.I<SettingsRepository>().setPurchasedProductIds(
                purchaseDetails.productID,
              );

              notifier.reset();
            }

            if (purchaseDetails.pendingCompletePurchase) {
              await notifier.handleEndPurchase(purchaseDetails);

              notifier.reset();
            }
          }
        }
      },
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
              subtitle: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'This app is free and ad-free, and I intend to keep it that way for the foreseeable future. If you enjoy the app, please consider supporting it. ',
                    ),
                    TextSpan(
                      text:
                          'Please note that there are currently no additional features or benefits for supporters, but it might change in the near future.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
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
                onPressed: () {
                  ObservatorySnackBar.show(
                    context,
                    icon: Icons.refresh,
                    content: const Text('Restoring purchases...'),
                  );

                  notifier.restore().then(
                    (value) {
                      if (context.mounted) {
                        if (value) {
                          ObservatorySnackBar.show(
                            context,
                            icon: Icons.check,
                            content: const Text('Purchases restored!'),
                          );
                        } else {
                          ObservatorySnackBar.show(
                            context,
                            icon: Icons.info,
                            content: const Text('No purchases to restore.'),
                          );
                        }
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
