import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/deal/ui/price_cut.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/models/price.dart';
import 'package:observatory/shared/ui/dot_separator.dart';

class DealCardCompactInfoRow extends ConsumerWidget {
  const DealCardCompactInfoRow({
    super.key,
    required this.deal,
  });

  final Deal deal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Builder(
      builder: (context) {
        final Price? price = deal.prices?.firstOrNull;

        if (price == null) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'No prices are available for this product in the selected stores.',
                  style: context.themes.text.titleSmall?.copyWith(
                    color: context.colors.disabled,
                  ),
                ),
              ),
            ],
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  PriceCut(
                    priceCut: price.cut,
                  ),
                  const DotSeparator(),
                  Text(
                    price.price.formattedPrice,
                    style: context.themes.text.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                      color: context.colors.scheme.onSurface,
                    ),
                  )
                ],
              ),
              const Divider(),
              Text(
                price.shop.name,
                style: context.themes.text.labelMedium?.copyWith(
                  overflow: TextOverflow.ellipsis,
                  color: context.colors.scheme.onSurface,
                ),
              ),
              RichText(
                maxLines: 2,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'DRM: ',
                      style: context.themes.text.labelSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colors.scheme.onSurfaceVariant,
                      ),
                    ),
                    TextSpan(
                      text: price.formattedDRM,
                      style: context.themes.text.labelSmall?.copyWith(
                        color: context.colors.scheme.onSurfaceVariant,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
