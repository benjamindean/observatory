import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:intl/intl.dart';
import 'package:observatory/shared/models/deal.dart';

Future<bool> showWaitlistNotification({
  required List<Deal> deals,
}) {
  if (deals.isEmpty) {
    return Future.value(false);
  }

  final String notificationTitle = Intl.plural(
    deals.length,
    one: '${deals.length} game from your waitlist is on sale!',
    other: '${deals.length} games from your waitlist are on sale!',
  );

  final String restText = Intl.plural(
    deals.length - 1,
    one: 'game is',
    other: 'games are',
  );

  final String notificationBody = Intl.plural(
    deals.length,
    one: '${deals[0].titleParsed} is ${deals[0].bestPrice.cut.toInt()}% off.',
    two:
        '${deals[0].titleParsed} is ${deals[0].bestPrice.cut.toInt()}% off and ${deals[1].titleParsed} is ${deals[1].bestPrice.cut.toInt()}% off.',
    other:
        '${deals[0].titleParsed} is ${deals[0].bestPrice.cut.toInt()}% off, ${deals[1].titleParsed} is ${deals[1].bestPrice.cut.toInt()}% off and ${deals.length - 2} other $restText on sale.',
  );

  return AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 10,
      channelKey: 'observatory_channel',
      title: notificationTitle,
      body: notificationBody,
      actionType: ActionType.Default,
    ),
  );
}
