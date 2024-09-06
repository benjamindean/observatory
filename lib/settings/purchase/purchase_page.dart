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

class PurchasePage extends ConsumerStatefulWidget {
  const PurchasePage({super.key});

  @override
  PurchasePageState createState() => PurchasePageState();
}

class PurchasePageState extends ConsumerState<PurchasePage> {
  StreamSubscription<List<PurchaseDetails>>? _purchaseStream;

  @override
  void initState() {
    super.initState();

    final AsyncPurchaseNotifier notifier = ref.read(
      asyncPurchaseProvider.notifier,
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
              await GetIt.I<SettingsRepository>().setPurchasedProductIds(
                purchaseDetails.productID,
              );

              return notifier.setIsPending(false);
            }

            if (purchaseDetails.pendingCompletePurchase) {
              await InAppPurchase.instance.completePurchase(purchaseDetails);

              notifier.setIsPending(false);
            }
          }
        }
      },
    );
  }

  @override
  void dispose() {
    _purchaseStream?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<PurchaseState> purchases = ref.watch(
      asyncPurchaseProvider,
    );

    return Scaffold(
      appBar: AppBar(),
      body: purchases.when(
        data: (state) {
          if (state.products.isEmpty) {
            return const SizedBox.shrink();
          }

          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                  child: Text(
                    'Observatory Plus',
                    style: context.textStyles.headlineMedium.copyWith(
                      color: context.colors.scheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const ListTile(
                  subtitle: Column(
                    children: [
                      Text(
                        'This app is free and ad-free, and I intend to keep it that way for the foreseeable future. If you enjoy the app, please consider supporting it. ',
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Please note that there are currently no additional features or benefits for supporters, but it might change in the near future.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextButton.icon(
                      onPressed: () {
                        ObservatorySnackBar.show(
                          context,
                          icon: Icons.refresh,
                          content: const Text('Restoring purchases...'),
                        );

                        ref
                            .watch(asyncPurchaseProvider.notifier)
                            .restore()
                            .then(
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
                                  content:
                                      const Text('No purchases to restore.'),
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
                  ),
                ),
              ],
            ),
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
      ),
    );
  }
}
