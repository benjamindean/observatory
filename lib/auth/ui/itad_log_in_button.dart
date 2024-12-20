import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/auth/state/itad_state.dart';
import 'package:observatory/auth/providers/itad_provider.dart';
import 'package:observatory/auth/ui/log_in_button.dart';
import 'package:url_launcher/url_launcher.dart';

class ITADLogInButton extends ConsumerWidget {
  const ITADLogInButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ITADState itadState = ref.watch(itadProvider);

    return LogInButton(
      label: 'IsThereAnyDeal',
      color: const Color(0xFF1592e6),
      iconBuilder: () {
        return CircleAvatar(
          backgroundColor: const Color(0xFF1b1c24),
          backgroundImage: Image.asset('assets/images/itad-logo.jpg').image,
        );
      },
      onPressed: () {
        if (itadState.user != null) {
          ref.read(itadProvider.notifier).importData();

          return;
        }

        ref.read(itadProvider.notifier).reset().then((_) {
          launchUrl(
            ref.read(itadProvider.notifier).getAuthURL(),
            mode: LaunchMode.externalApplication,
          );
        });
      },
      onLogOut: () {
        ref.read(itadProvider.notifier).unlinkAccount();
      },
      text: Text.rich(
        TextSpan(
          children: [
            const TextSpan(
              text: 'Log In With ',
            ),
            TextSpan(
              text: 'IsThereAnyDeal',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      username: itadState.user?.username,
      isLoading: itadState.isLoading,
    );
  }
}
