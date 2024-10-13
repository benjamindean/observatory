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
      return SizedBox.shrink();
    }

    final AsyncValue<PurchaseState> purchases = ref.watch(
      asyncPurchaseProvider,
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: FilledButton.icon(
          style: FilledButton.styleFrom(
            backgroundColor: context.colors.scheme.secondary,
            padding: const EdgeInsets.all(8.0),
          ),
          icon: SizedBox(
            width: 32,
            height: 32,
            child: purchases.isLoading
                ? ObservatoryProgressIndicator(
                    color: context.colors.scheme.onSecondary,
                    size: 26,
                  )
                : CircleAvatar(
                    backgroundColor: context.colors.scheme.onSecondary,
                    child: Image.asset(
                      'assets/icon/observatory.png',
                      width: 32,
                      height: 32,
                    ),
                  ),
          ),
          onPressed: purchases.hasValue
              ? () {
                  context.push('/observatory-plus');
                }
              : null,
          label: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Get Observatory Plus',
              style: context.textStyles.bodyLarge.copyWith(
                color: context.colors.scheme.onSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
