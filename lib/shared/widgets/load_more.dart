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
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Builder(
            builder: (BuildContext context) {
              if (isLoading) {
                return const ITADProgressIndicator();
              }

              return OutlinedButton(
                child: const Text('Load More'),
                onPressed: () async {
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
