import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CloseBottomSheetButton extends StatelessWidget {
  const CloseBottomSheetButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: const Key('close-bottom-sheet-button'),
      onPressed: () {
        context.pop();
      },
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: context.colors.scheme.onSurfaceVariant,
      ),
    );
  }
}
