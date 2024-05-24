import 'package:collection/collection.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:observatory/notifications/waitlist_notification.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/api/api.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/tasks/constants.dart';
import 'package:workmanager/workmanager.dart';

Future<List<Deal>> getNewDiscountedDeals() async {
  final SettingsRepository settingsRepository = GetIt.I<SettingsRepository>();

  final List<Deal> waitlist = await GetIt.I<API>().fetchWaitlist();
  final List<Deal> pastWaitlist = settingsRepository.getWaitlistPast();

  final List<Deal> updatedDeals = List.from(waitlist)
    ..retainWhere((deal) {
      final Deal? pastDeal = pastWaitlist.singleWhereOrNull(
        (pastDeal) => pastDeal.id == deal.id,
      );

      if (pastDeal == null) {
        return true;
      }

      if (deal.bestPrice.cut > pastDeal.bestPrice.cut) {
        return true;
      }

      return false;
    })
    ..removeWhere(
      (deal) => deal.bestPrice.cut == 0,
    )
    ..sort(
      (a, b) {
        return (a.added).compareTo(b.added);
      },
    );

  await settingsRepository.setWaitlistPast(waitlist);

  Logger().d({
    'waitlist': waitlist.length,
    'pastWaitlist': pastWaitlist.length,
    'updatedDeals': updatedDeals.length,
  });

  return updatedDeals;
}

Future<bool> checkWaitlistTask() async {
  if (!GetIt.I.get<SettingsRepository>().getWaitlistNotifications()) {
    return false;
  }

  await FirebaseAnalytics.instance.logEvent(
    name: 'check_waitlist_notification_sent',
  );

  final List<Deal> deals = await getNewDiscountedDeals();

  return await showWaitlistNotification(
    deals: deals,
  );
}

Future<void> enableCheckWaitlistTask({
  Duration frequency = const Duration(hours: 3),
}) async {
  Logger().d('Enabling $TASK_CHECK_WAITLIST task');

  return Workmanager().registerPeriodicTask(
    TASK_CHECK_WAITLIST,
    TASK_CHECK_WAITLIST,
    frequency: frequency,
    initialDelay: const Duration(minutes: 30),
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
  );
}

Future<void> disableCheckWaitlistTask() async {
  Logger().d('Disabling $TASK_CHECK_WAITLIST task');

  return Workmanager().cancelByUniqueName(TASK_CHECK_WAITLIST);
}
