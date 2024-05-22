import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get_it/get_it.dart';
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

  await settingsRepository.setWaitlistPast(waitlist);

  return List.from(waitlist)
    ..retainWhere((deal) {
      final Deal pastValue = pastWaitlist.singleWhere(
        (pastDeal) => pastDeal.id == deal.id,
        orElse: () => const Deal(id: 'none'),
      );

      if (pastValue.id == 'none') {
        return true;
      }

      if ((pastValue.prices?.first.cut ?? 0) < (deal.prices?.first.cut ?? 0)) {
        return true;
      }

      return false;
    })
    ..removeWhere(
      (deal) => deal.prices == null || (deal.prices?.first.cut ?? 0) == 0,
    );
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
  return Workmanager().registerPeriodicTask(
    TASK_CHECK_WAITLIST,
    TASK_CHECK_WAITLIST,
    frequency: frequency,
    initialDelay: const Duration(hours: 1),
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
  );
}

Future<void> disableCheckWaitlistTask() async {
  return Workmanager().cancelByUniqueName(TASK_CHECK_WAITLIST);
}
