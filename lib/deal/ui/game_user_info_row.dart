import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/deal/ui/added_on_hint.dart';
import 'package:observatory/deal/ui/in_library_hint.dart';
import 'package:observatory/library/providers/library_provider.dart';
import 'package:observatory/shared/models/deal.dart';

class GameUserInfoRow extends ConsumerWidget {
  const GameUserInfoRow({
    super.key,
    required this.deal,
  });

  final Deal deal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> library = ref.watch(libraryIdsProvider);
    final bool isInLibrary = library.contains(deal.id);

    if (!isInLibrary && deal.added == 0) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Row(
        children: [
          InLibraryHint(
            isInLibrary: isInLibrary,
          ),
          if (isInLibrary) const SizedBox(width: 8.0),
          AddedOnHint(
            added: deal.added,
          ),
        ],
      ),
    );
  }
}
