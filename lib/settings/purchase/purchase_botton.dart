import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:observatory/settings/purchase/purchase_provider.dart';
import 'package:observatory/settings/purchase/purchase_state.dart';
import 'package:go_router/go_router.dart';

class PurchaseButton extends ConsumerWidget {
  const PurchaseButton({super.key});

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

        return Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: SizedBox(
            width: double.infinity,
            height: 60,
            child: FilledButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  context.colors.scheme.secondary,
                ),
              ),
              onPressed: () {
                context.push('/observatory-plus');
              },
              child: Text(
                'Get Observatory Plus',
                style: context.textStyles.bodyLarge.copyWith(
                  color: context.colors.scheme.onSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
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
    );
  }
}
