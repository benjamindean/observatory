import 'package:flutter/material.dart';
import 'package:observatory/shared/widgets/progress_indicator.dart';

class LoadMore extends StatefulWidget {
  final Function onPress;

  const LoadMore({
    super.key,
    required this.onPress,
  });

  @override
  LoadMoreState createState() => LoadMoreState();
}

class LoadMoreState extends State<LoadMore> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Builder(
            builder: (BuildContext context) {
              return OutlinedButton.icon(
                icon: isLoading
                    ? const ObservatoryIconProgressIndicator()
                    : const Icon(Icons.download_rounded),
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
              );
            },
          ),
        ),
      ),
    );
  }
}
