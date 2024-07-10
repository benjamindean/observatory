import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/deal/deal_functions.dart';
import 'package:observatory/deal/ui/bookmark_button.dart';
import 'package:observatory/deal/ui/waitlist_button.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/ui/constants.dart';
import 'package:observatory/shared/ui/observatory_back_button.dart';

class DealPageBottomAppBar extends ConsumerWidget {
  const DealPageBottomAppBar({
    super.key,
    required this.deal,
  });

  final Deal deal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomAppBar(
      elevation: APPBAR_ELEVATION,
      surfaceTintColor: context.colors.scheme.surfaceTint,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Expanded(
            flex: 40,
            child: ObservatoryBackButton(),
          ),
          Expanded(
            flex: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                Tooltip(
                  message: 'Open in Browser',
                  child: IconButton(
                    onPressed: deal.prices?.firstOrNull != null
                        ? () => DealFunctions.openDealLink(deal)
                        : null,
                    icon: Icon(
                      Icons.open_in_browser,
                      color: deal.prices?.firstOrNull != null
                          ? context.colors.scheme.secondary
                          : context.colors.disabled,
                    ),
                  ),
                ),
                Tooltip(
                  message: 'Share Link',
                  child: IconButton(
                    onPressed: deal.prices?.firstOrNull != null
                        ? () => DealFunctions.shareDeal(deal)
                        : null,
                    icon: Icon(
                      Icons.share,
                      color: deal.prices?.firstOrNull != null
                          ? context.colors.scheme.tertiary
                          : context.colors.disabled,
                    ),
                  ),
                ),
                BookmarkButton(deal: deal),
                WaitlistButton(deal: deal),
              ],
            ),
          )
        ],
      ),
    );
  }
}
