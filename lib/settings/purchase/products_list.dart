import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/settings/purchase/purchase_provider.dart';
import 'package:observatory/settings/purchase/purchase_state.dart';
import 'package:observatory/shared/ui/observatory_shimmer.dart';
import 'package:observatory/shared/widgets/progress_indicator.dart';

class ProductsList extends ConsumerStatefulWidget {
  const ProductsList({super.key});

  @override
  ConsumerState<ProductsList> createState() => ProductsListState();
}

class ProductsListState extends ConsumerState<ProductsList> {
  String? selectedProduct;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<PurchaseState> purchases = ref.watch(
      asyncPurchaseProvider,
    );

    return purchases.when(
      data: (state) {
        if (selectedProduct == null && state.products.isNotEmpty) {
          selectedProduct = state.products.first.id;
        }

        if (state.purchasedProductIds.isNotEmpty) {
          return Text(
            'Thank you for your support!',
            style: context.themes.text.titleMedium?.copyWith(
              color: context.colors.scheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          );
        }

        if (state.isPending) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 22.0, horizontal: 4.0),
            child: ObservatoryShimmer(),
          );
        }

        return Column(
          children: [
            Column(
              children: state.products.map<Widget>(
                (e) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: RadioListTile<String>(
                      title: Text(e.price),
                      subtitle: Text(e.title),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: context.colors.scheme.primary,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      value: e.id,
                      groupValue: selectedProduct,
                      onChanged: (String? value) {
                        setState(() {
                          selectedProduct = value;
                        });
                      },
                    ),
                  );
                },
              ).toList(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
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
                    ref.read(asyncPurchaseProvider.notifier).purchase(
                          state.products.firstWhere(
                            (element) => element.id == selectedProduct,
                          ),
                        );
                  },
                  child: state.isPending
                      ? ObservatoryProgressIndicator(
                          color: context.colors.scheme.onSecondary,
                          size: 30,
                        )
                      : Text(
                          'Purchase Now',
                          style: context.textStyles.bodyLarge.copyWith(
                            color: context.colors.scheme.onSecondary,
                          ),
                        ),
                ),
              ),
            ),
          ],
        );
      },
      loading: () {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 22.0),
          child: ObservatoryShimmer(),
        );
      },
      error: (error, stackTrace) {
        return const SizedBox.shrink();
      },
    );
  }
}
