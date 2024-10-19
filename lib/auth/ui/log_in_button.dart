import 'package:flutter/material.dart';
import 'package:observatory/shared/widgets/progress_indicator.dart';
import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';

class LogInButton extends StatelessWidget {
  final Color color;
  final bool isLoading;
  final Function iconBuilder;
  final VoidCallback onPressed;
  final VoidCallback onLogOut;
  final String? username;
  final Widget text;
  final String label;

  const LogInButton({
    super.key,
    required this.color,
    required this.iconBuilder,
    required this.onPressed,
    required this.onLogOut,
    required this.text,
    required this.username,
    required this.isLoading,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SizedBox(
            height: 54,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                backgroundColor: color,
                foregroundColor: Colors.black87,
                overlayColor: Colors.white70,
              ),
              onPressed: onPressed,
              label: username != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  label,
                                  style: TextStyle(
                                    fontSize:
                                        context.textStyles.labelSmall.fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text.rich(
                                  style: TextStyle(
                                    fontSize:
                                        context.textStyles.labelLarge.fontSize,
                                  ),
                                  TextSpan(
                                    children: <TextSpan>[
                                      const TextSpan(
                                        text: 'Sync from ',
                                      ),
                                      TextSpan(
                                        text: username,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
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
                          onPressed: onLogOut,
                          child: Text(
                            'Log Out',
                            style: TextStyle(
                              color: context.colors.scheme.onErrorContainer,
                            ),
                          ),
                        )
                      ],
                    )
                  : Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: text,
                        ),
                      ],
                    ),
              icon: SizedBox(
                width: 32,
                height: 32,
                child: Center(
                  child: isLoading
                      ? ObservatoryProgressIndicator(
                          color: context.colors.scheme.onPrimary,
                          size: 26,
                        )
                      : iconBuilder(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
