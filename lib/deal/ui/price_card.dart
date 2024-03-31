import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:observatory/deal/ui/price_cut.dart';
import 'package:observatory/deal/ui/voucher_list_tile.dart';
import 'package:observatory/shared/models/price.dart';
import 'package:url_launcher/url_launcher.dart';

class PriceCard extends StatelessWidget {
  const PriceCard({
    super.key,
    required this.price,
  });

  final Price price;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Column(
        children: [
          ListTile(
            leading: SizedBox(
              width: 50,
              child: Center(
                child: PriceCut(
                  priceCut: price.cut,
                ),
              ),
            ),
            title: Text(price.shop.name),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
            trailing: Text(
              price.price.formattedPrice,
              style: context.themes.text.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colors.scheme.onBackground,
              ),
            ),
            onTap: () {
              launchUrl(
                Uri.parse(price.url),
                mode: LaunchMode.externalApplication,
              );
            },
          ),
          if (price.voucher != null && price.voucher != '')
            VoucherListTile(price: price),
        ],
      ),
    );
  }
}
