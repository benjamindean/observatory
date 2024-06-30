import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String? message;
  final IconData icon;
  final Widget? helper;
  final Widget? child;

  const ErrorMessage({
    super.key,
    this.message,
    this.icon = Icons.warning,
    this.helper,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    icon,
                    color: context.colors.disabled,
                    size: 50,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Builder(
                  builder: (context) {
                    if (message != null) {
                      return Flexible(
                        child: Text(
                          message ?? 'Unknown Error',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: context.themes.text.bodyMedium?.fontSize,
                            color: context.colors.disabled,
                          ),
                        ),
                      );
                    }

                    return child ?? const SizedBox.shrink();
                  },
                )
              ],
            ),
            helper ?? const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
