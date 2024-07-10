import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/deal/ui/deal_card_compact.dart';
import 'package:observatory/deal/ui/deal_card_expanded.dart';
import 'package:observatory/router.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/models/deal.dart';

class DealCard extends ConsumerWidget {
  final Deal deal;
  final DealCardType cardType;
  final NavigationBranch page;

  const DealCard({
    super.key,
    required this.deal,
    required this.cardType,
    required this.page,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (cardType) {
      case DealCardType.compact:
        return DealCardCompact(
          deal: deal,
          page: page,
        );
      case DealCardType.expanded:
        return DealCardExpanded(
          deal: deal,
          page: page,
        );
      default:
        return DealCardCompact(
          deal: deal,
          page: page,
        );
    }
  }
}
