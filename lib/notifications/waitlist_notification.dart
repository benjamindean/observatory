import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:intl/intl.dart';
import 'package:observatory/shared/models/deal.dart';

String getNotificationBody(List<Deal> deals) {
  if (deals.length == 1) {
    return '${deals[0].titleParsed} is ${deals[0].bestPrice.cut.toInt()}% off.';
  }

  if (deals.length == 2) {
    return '${deals[0].titleParsed} is ${deals[0].bestPrice.cut.toInt()}% off and ${deals[1].titleParsed} is ${deals[1].bestPrice.cut.toInt()}% off.';
  }

  final int leftoverDeals = deals.length - 2;
  final String restText = Intl.plural(
    leftoverDeals,
    one: 'game is',
    other: 'games are',
  );

  return '${deals[0].titleParsed} is ${deals[0].bestPrice.cut.toInt()}% off, ${deals[1].titleParsed} is ${deals[1].bestPrice.cut.toInt()}% off and $leftoverDeals other $restText on sale.';
}

Future<bool> showWaitlistNotification({
  required List<Deal> deals,
}) {
  if (deals.isEmpty) {
    return Future.value(true);
  }

  final String notificationTitle = Intl.plural(
    deals.length,
    one: '${deals.length} game from your waitlist is on sale!',
    other: '${deals.length} games from your waitlist are on sale!',
  );

  return AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 10,
      channelKey: 'observatory_channel',
      title: notificationTitle,
      body: getNotificationBody(deals),
      actionType: ActionType.Default,
    ),
  );
}
