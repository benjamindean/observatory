import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:observatory/shared/widgets/error_message.dart';

class EmptyWaitlist extends StatelessWidget {
  const EmptyWaitlist({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ErrorMessage(
              message:
                  'Your waitlist is empty. You can add games from the Deals or Search tabs.',
              icon: Icons.heart_broken,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                spacing: 1.0,
                runSpacing: 1.0,
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      context.go('/deals');
                    },
                    icon: const Icon(Icons.percent_rounded),
                    label: const Text('Deals'),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      context.push('/steam-import');
                    },
                    icon: const Icon(Icons.download),
                    label: const Text('Import from Steam'),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      context.go('/search');
                    },
                    icon: const Icon(Icons.search),
                    label: const Text('Search'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
