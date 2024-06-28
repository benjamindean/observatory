import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:observatory/shared/widgets/progress_indicator.dart';

class LoadMore extends StatefulWidget {
  final Function onPress;
  final bool hasReachedMax;

  const LoadMore({
    super.key,
    required this.onPress,
    required this.hasReachedMax,
  });

  @override
  LoadMoreState createState() => LoadMoreState();
}

class LoadMoreState extends State<LoadMore> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    if (widget.hasReachedMax) {
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
        child: OutlinedButton.icon(
          icon: isLoading
              ? const ObservatoryIconProgressIndicator()
              : const Icon(Icons.arrow_downward_rounded),
          label: const Text('Load More'),
          onPressed: isLoading
              ? null
              : () async {
                  setState(() {
                    isLoading = true;
                  });

                  await widget.onPress();

                  setState(() {
                    isLoading = false;
                  });
                },
        ),
      ),
    );
  }
}
