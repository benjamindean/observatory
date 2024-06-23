import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:observatory/deal/ui/deal_bottom_sheet.dart';
import 'package:observatory/deal/ui/deal_card_info_row.dart';
import 'package:observatory/settings/providers/settings_provider.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/ui/observatory_card.dart';
import 'package:observatory/shared/widgets/header_image.dart';

class DealCardExpanded extends ConsumerWidget {
  final Deal deal;

  const DealCardExpanded({
    super.key,
    required this.deal,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool showHeaders = ref.watch(
      asyncSettingsProvider.select(
        (value) => value.value?.showHeaders ?? false,
      ),
    );

    return InkWell(
      splashColor: context.colors.scheme.primaryContainer,
      splashFactory: InkSparkle.splashFactory,
      onTap: () => onCardTap(context),
      borderRadius: BorderRadius.circular(16),
      onLongPress: () {
        HapticFeedback.mediumImpact();

        showModalBottomSheet(
          context: context,
          useSafeArea: true,
          useRootNavigator: true,
          builder: (BuildContext context) {
            return Consumer(
              builder: (context, ref, _) {
                return DealBottomSheet(deal: deal);
              },
            );
          },
        );
      },
      child: ObservatoryCard(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Builder(
              builder: (context) {
                if (!showHeaders) {
                  return const SizedBox.shrink();
                }

                return Expanded(
                  child: HeaderImage(
                    url: deal.headerImageURL,
                  ),
                );
              },
            ),
            Center(child: DealCardInfoRow(deal: deal)),
          ],
        ),
      ),
    );
  }

  void onCardTap(BuildContext context) {
    context.push('/deal', extra: deal);
  }
}
