import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:collection/collection.dart';
import 'package:observatory/shared/widgets/progress_indicator.dart';

class ProductsList extends StatefulWidget {
  final bool isPending;
  final Function(ProductDetails) onPurchase;
  final List<ProductDetails> products;
  final List<String> purchasedProductIds;

  const ProductsList({
    super.key,
    required this.isPending,
    required this.onPurchase,
    required this.products,
    required this.purchasedProductIds,
  });

  @override
  State<ProductsList> createState() => ProductsListState();
}

class ProductsListState extends State<ProductsList> {
  ProductDetails selectedProduct = ProductDetails(
    id: '0',
    title: 'Unknown',
    description: 'Unknown',
    price: 0.toString(),
    rawPrice: 0,
    currencyCode: 'USD',
  );

  @override
  void initState() {
    super.initState();

    selectedProduct = widget.products.first;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.products.isEmpty) {
      return const Center(
        child: ObservatoryProgressIndicator(),
      );
    }

    final ProductDetails? currentProduct = widget.products.firstWhereOrNull(
      (e) => e == selectedProduct,
    );

    return Column(
      children: [
        Column(
          children: widget.products.map<Widget>(
            (e) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: RadioListTile<ProductDetails>(
                  title: Text(e.price),
                  subtitle: Text(e.title),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: context.colors.scheme.primary,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  value: e,
                  groupValue: selectedProduct,
                  onChanged: !widget.isPending
                      ? (ProductDetails? value) {
                          setState(() {
                            selectedProduct = value!;
                          });
                        }
                      : null,
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
                widget.onPurchase(selectedProduct);
              },
              child: widget.isPending
                  ? ObservatoryProgressIndicator(
                      color: context.colors.scheme.onSecondary,
                      size: 30,
                    )
                  : Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Purchase Now for ',
                            style: context.textStyles.bodyLarge.copyWith(
                              color: context.colors.scheme.onSecondary,
                            ),
                          ),
                          TextSpan(
                            text: currentProduct != null
                                ? currentProduct.price
                                : '',
                            style: context.textStyles.bodyLarge.copyWith(
                              color: context.colors.scheme.onSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
