import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/deal/deal_functions.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/waitlist/providers/waitlist_provider.dart';

class WaitlistButton extends ConsumerWidget {
  final Deal deal;

  const WaitlistButton({
    super.key,
    required this.deal,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> waitlist = ref.watch(waitlistIdsProvider);
    final bool isInWaitlist = waitlist.contains(deal.id);

    return Tooltip(
      message: isInWaitlist ? 'Remove from Waitlist' : 'Add to Waitlist',
      child: IconButton(
        icon: Icon(
          isInWaitlist ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          color: context.colors.primary,
        ),
        onPressed: () => onPressed(isInWaitlist, ref, context),
      ),
    );
  }

  Future<void> onPressed(
    bool isInWaitlist,
    WidgetRef ref,
    BuildContext context,
  ) async {
    if (isInWaitlist) {
      return DealFunctions.removeDealFromWaitlist(
        context: context,
        ref: ref,
        deal: deal,
      );
    }

    return DealFunctions.addDealToWaitlist(
      context: context,
      ref: ref,
      deal: deal,
    );
  }
}
