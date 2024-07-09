import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/bookmarks/providers/bookmarks_provider.dart';
import 'package:observatory/deal/ui/deal_card_compact.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/ui/bottom_sheet_container.dart';
import 'package:observatory/shared/ui/bottom_sheet_heading.dart';
import 'package:observatory/shared/ui/close_bottom_sheet_button.dart';
import 'package:observatory/shared/ui/rounded_container.dart';

void showBookmarks(BuildContext context) {
  showModalBottomSheet(
    useRootNavigator: true,
    useSafeArea: true,
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return const BookmarksPage();
    },
  );
}

class BookmarksPage extends ConsumerWidget {
  const BookmarksPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Deal> bookmarks =
        ref.watch(asyncBookmarksProvider).valueOrNull ?? [];

    return BottomSheetContainer(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BottomSheetHeading(
              text: 'Bookmarks',
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CloseBottomSheetButton(),
                ],
              ),
            ),
            Expanded(
              child: RoundedContainer(
                child: ListView.builder(
                  itemCount: bookmarks.length,
                  itemBuilder: (context, index) {
                    return DealCardCompact(deal: bookmarks[index]);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
