import 'dart:io';

import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/settings/purchase/purchase_provider.dart';
import 'package:observatory/settings/purchase/purchase_state.dart';
import 'package:go_router/go_router.dart';
import 'package:observatory/shared/widgets/progress_indicator.dart';

class PurchaseButton extends ConsumerWidget {
  const PurchaseButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (Platform.isAndroid) {
      return const SizedBox.shrink();
    }

    final AsyncValue<PurchaseState> purchases = ref.watch(
      asyncPurchaseProvider,
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: FilledButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              context.colors.scheme.secondary,
            ),
          ),
          onPressed: purchases.hasValue
              ? () {
                  context.push('/observatory-plus');
                }
              : null,
          child: purchases.isLoading
              ? ObservatoryProgressIndicator(
                  color: context.colors.scheme.onSecondary,
                  size: 26,
                )
              : Text(
                  'Get Observatory Plus',
                  style: context.textStyles.bodyLarge.copyWith(
                    color: context.colors.scheme.onSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}
