import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/auth/itad_state.dart';
import 'package:observatory/auth/providers/itad_provider.dart';
import 'package:observatory/shared/widgets/progress_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';

class ITADLogInButton extends ConsumerWidget {
  const ITADLogInButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ITADState itadState = ref.watch(itadProvider);

    Widget getIcon() {
      if (itadState.isLoading) {
        return ObservatoryProgressIndicator(
          color: context.colors.scheme.onPrimary,
          size: 26,
        );
      }

      return CircleAvatar(
        backgroundColor: const Color(0xFF1b1c24),
        backgroundImage: Image.asset('assets/images/itad-logo.jpg').image,
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SizedBox(
            height: 48,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.all(8.0),
                backgroundColor: const Color(0xFF1592e6),
              ),
              onPressed: () async {
                if (itadState.itadUser != null) {
                  ref.read(itadProvider.notifier).import();

                  return;
                }

                launchUrl(
                  ref.read(itadProvider.notifier).getAuthURL(),
                  mode: LaunchMode.externalApplication,
                );
              },
              label: itadState.itadUser != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text.rich(
                              TextSpan(
                                children: <TextSpan>[
                                  const TextSpan(
                                    text: 'Sync from ',
                                  ),
                                  TextSpan(
                                    text: itadState.itadUser!.username,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor:
                                context.colors.scheme.errorContainer,
                            visualDensity: VisualDensity.compact,
                          ),
                          onPressed: () {
                            ref.read(itadProvider.notifier).unlinkAccount();
                          },
                          child: Text(
                            'Log Out',
                            style: TextStyle(
                              color: context.colors.scheme.onErrorContainer,
                            ),
                          ),
                        )
                      ],
                    )
                  : const Padding(
                      padding: EdgeInsets.only(left: 4.0),
                      child: Text('Log In With IsThereAnyDeal'),
                    ),
              icon: SizedBox(
                width: 32,
                height: 32,
                child: Center(
                  child: getIcon(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
