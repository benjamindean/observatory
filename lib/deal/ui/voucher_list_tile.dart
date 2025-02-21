import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:observatory/shared/models/price.dart';
import 'package:observatory/shared/ui/observatory_snack_bar.dart';

class VoucherListTile extends StatelessWidget {
  const VoucherListTile({
    super.key,
    required this.price,
  });

  final Price price;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.scheme.surfaceContainerHigh,
      child: ListTile(
        onTap: () async {
          await Clipboard.setData(ClipboardData(text: price.voucher ?? ''))
              .then((value) {
            if (context.mounted) {
              ObservatorySnackBar.show(
                context,
                content: Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Voucher ',
                        style:
                            context.themes.snackBar.contentTextStyle?.copyWith(
                          color: context.colors.scheme.onInverseSurface,
                        ),
                      ),
                      TextSpan(
                        text: price.voucher ?? 'None',
                        style:
                            context.themes.snackBar.contentTextStyle?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colors.scheme.onInverseSurface,
                        ),
                      ),
                      TextSpan(
                        text: ' copied to clipboard.',
                        style:
                            context.themes.snackBar.contentTextStyle?.copyWith(
                          color: context.colors.scheme.onInverseSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          });
        },
        dense: true,
        visualDensity: VisualDensity.compact,
        trailing: const Icon(
          Icons.copy,
          size: 16,
        ),
        title: Text.rich(
          maxLines: 2,
          TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: 'Voucher: ',
                style: context.themes.text.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colors.scheme.onSurfaceVariant,
                ),
              ),
              TextSpan(
                text: price.voucher ?? 'None',
                style: context.themes.text.labelLarge?.copyWith(
                  color: context.colors.scheme.onSurfaceVariant,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
