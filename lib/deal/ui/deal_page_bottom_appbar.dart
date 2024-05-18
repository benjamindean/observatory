import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/deal/deal_functions.dart';
import 'package:observatory/deal/ui/waitlist_button.dart';
import 'package:observatory/shared/context_extension.dart';
import 'package:observatory/shared/models/deal.dart';

class DealPageBottomAppBar extends ConsumerWidget {
  const DealPageBottomAppBar({
    super.key,
    required this.deal,
  });

  final Deal deal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomAppBar(
      color: context.colors.scheme.surface,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            flex: 50,
            child: BackButton(
              style: IconButton.styleFrom(
                backgroundColor: context.elevatedCanvasColor,
              ),
            ),
          ),
          Expanded(
            flex: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                Tooltip(
                  message: 'Open in Browser',
                  child: IconButton(
                    onPressed: deal.prices?.firstOrNull != null
                        ? () => openDealLink(deal)
                        : null,
                    icon: Icon(
                      Icons.open_in_browser,
                      color: deal.prices?.firstOrNull != null
                          ? context.colors.scheme.tertiary
                          : context.colors.disabled,
                    ),
                  ),
                ),
                Tooltip(
                  message: 'Share Link',
                  child: IconButton(
                    onPressed: deal.prices?.firstOrNull != null
                        ? () => shareDeal(deal)
                        : null,
                    icon: Icon(
                      Icons.share,
                      color: deal.prices?.firstOrNull != null
                          ? context.colors.scheme.tertiary
                          : context.colors.disabled,
                    ),
                  ),
                ),
                WaitlistButton(deal: deal),
              ],
            ),
          )
        ],
      ),
    );
  }
}
