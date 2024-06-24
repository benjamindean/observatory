import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/settings/providers/settings_provider.dart';

class WaitlistAlertsSettingsTile extends ConsumerWidget {
  const WaitlistAlertsSettingsTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isEnabled = ref.watch(
      asyncSettingsProvider.select(
        (value) => value.valueOrNull?.waitlistNotifications ?? false,
      ),
    );

    return SwitchListTile(
      value: isEnabled,
      title: const Text('Discount Alerts'),
      subtitle: const Text(
        'Receive notifications when games on your waitlist go on sale.',
      ),
      onChanged: (value) async {
        final bool isAllowed =
            await AwesomeNotifications().isNotificationAllowed();

        if (!isAllowed) {
          final bool result = await AwesomeNotifications()
              .requestPermissionToSendNotifications();

          return ref
              .watch(asyncSettingsProvider.notifier)
              .setWaitlistNotifications(result && value);
        }

        return ref
            .watch(asyncSettingsProvider.notifier)
            .setWaitlistNotifications(value);
      },
    );
  }
}
