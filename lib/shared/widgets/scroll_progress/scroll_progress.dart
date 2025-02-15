import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/shared/widgets/scroll_progress/scroll_progress_provider.dart';

class ScrollProgress extends ConsumerWidget {
  const ScrollProgress({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double scrollProgress = ref.watch(scrollProgressProvider);

    if (!scrollProgress.isFinite) {
      return const SizedBox.shrink();
    }

    return LinearProgressIndicator(
      key: const Key('scroll-progress'),
      value: scrollProgress,
      backgroundColor: NavigationBarTheme.of(context).backgroundColor,
      minHeight: 2.0,
    );
  }
}
