import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:observatory/shared/widgets/progress_indicator.dart';

class LoadMore extends HookWidget {
  final Function onPress;
  final bool hasReachedMax;

  const LoadMore({
    super.key,
    required this.onPress,
    required this.hasReachedMax,
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isLoading = useState(false);

    if (hasReachedMax) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'That\'s it!',
            style: context.textStyles.bodyLarge.copyWith(
              color: context.colors.hint,
            ),
          ),
        ),
      );
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: TextButton.icon(
          icon: isLoading.value
              ? const ObservatoryIconProgressIndicator()
              : const Icon(Icons.arrow_downward_rounded),
          label: const Text('Load More'),
          onPressed: isLoading.value
              ? null
              : () async {
                  isLoading.value = true;

                  await onPress();

                  isLoading.value = false;
                },
        ),
      ),
    );
  }
}
