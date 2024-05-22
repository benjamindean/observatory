import 'package:awesome_notifications/awesome_notifications.dart';

final NOTIFICATION_CHANNELS = [
  NotificationChannel(
    channelGroupKey: 'observatory_channel_group',
    channelKey: 'observatory_channel',
    channelName: 'Waitlist Notifications',
    channelDescription: 'Notifications about discounts on waitlisted items',
  ),
];

final NOTIFICATION_GROUPS = [
  NotificationChannelGroup(
    channelGroupKey: 'observatory_channel_group',
    channelGroupName: 'Waitlist Notifications',
  )
];
