import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/deal/ui/deal_card_compact.dart';
import 'package:observatory/deal/ui/deal_card_expanded.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/models/deal.dart';

class DealCard extends ConsumerWidget {
  final Deal deal;
  final DealCardType cardType;

  const DealCard({
    super.key,
    required this.deal,
    required this.cardType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (cardType) {
      case DealCardType.compact:
        return DealCardCompact(deal: deal);
      case DealCardType.expanded:
        return DealCardExpanded(deal: deal);
      default:
        return DealCardCompact(deal: deal);
    }
  }
}
