import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';

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

    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.library_add_check,
            color: context.colors.scheme.secondary,
            size: context.textStyles.labelLarge.fontSize,
          ),
          const SizedBox(width: 4.0),
          Text(
            'In Library',
            style: context.themes.text.labelSmall?.copyWith(
              color: context.colors.hint,
            ),
          )
        ],
      ),
    );
  }
}
