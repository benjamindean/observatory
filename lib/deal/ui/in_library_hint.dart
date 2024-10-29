import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:observatory/shared/ui/hint.dart';

class InLibraryHint extends StatelessWidget {
  const InLibraryHint({
    super.key,
    required this.isInLibrary,
  });

  final bool isInLibrary;

  @override
  Widget build(BuildContext context) {
    if (!isInLibrary) {
      return const SizedBox.shrink();
    }

    return Hint(
      icon: Icons.library_add_check,
      child: Text(
        'In Library',
        style: context.themes.text.labelSmall?.copyWith(
          color: context.colors.hint,
        ),
      ),
    );
  }
}
