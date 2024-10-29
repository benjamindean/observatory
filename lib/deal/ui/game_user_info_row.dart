import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/deal/ui/added_on_hint.dart';
import 'package:observatory/deal/ui/in_library_hint.dart';
import 'package:observatory/library/providers/library_provider.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';

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

    return ColoredBox(
      color: context.colors.scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        child: Row(
          children: [
            InLibraryHint(
              isInLibrary: isInLibrary,
            ),
            const SizedBox(width: 8.0),
            AddedOnHint(
              added: deal.added,
            ),
          ],
        ),
      ),
    );
  }
}
