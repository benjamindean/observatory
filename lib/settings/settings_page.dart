import 'package:country_picker/country_picker.dart';
import 'package:observatory/settings/purchase/purchase_tile.dart';
import 'package:observatory/settings/ui/about_links.dart';
import 'package:observatory/settings/ui/theme_list_tile.dart';
import 'package:observatory/settings/ui/theme_true_black_list_tile.dart';
import 'package:observatory/settings/ui/waitlist_alerts_settings_tile.dart';
import 'package:observatory/shared/ui/observatory_dialog.dart';
import 'package:observatory/waitlist/providers/waitlist_provider.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:observatory/settings/providers/settings_provider.dart';
import 'package:observatory/settings/state/settings_state.dart';
import 'package:observatory/settings/ui/deal_card_type_settings_tile.dart';
import 'package:observatory/settings/ui/header_images_settings_tile.dart';
import 'package:observatory/settings/ui/theme_mode_list_tile.dart';
import 'package:observatory/shared/widgets/error_message.dart';
import 'package:observatory/shared/widgets/list_heading.dart';
import 'package:observatory/shared/widgets/progress_indicator.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<SettingsState> settings = ref.watch(asyncSettingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: settings.when(
          loading: () => const ObservatoryProgressIndicator(),
          error: (error, stackTrace) {
            Logger().e(
              'Failed to load settings',
              error: error,
              stackTrace: stackTrace,
            );

            FirebaseCrashlytics.instance.recordError(
              error,
              stackTrace,
            );

            return ErrorMessage(
              message: 'Failed to load settings',
              helper: TextButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text('Refresh'),
                onPressed: () {
                  ref.read(asyncSettingsProvider.notifier).build();
                },
              ),
            );
          },
          data: (data) {
            final int totalStores = settings.value?.stores.length ?? 0;
            final int selectedCount =
                settings.value?.selectedStores.length ?? 0;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // const ListHeading(title: 'Account'),
                  // Padding(
                  //   padding: const EdgeInsets.all(6.0),
                  //   child: Card(
                  //     child: StreamBuilder<User?>(
                  //       initialData: null,
                  //       stream: FirebaseAuth.instance.authStateChanges(),
                  //       builder: (context, snapshot) {
                  //         if (!snapshot.hasData) {
                  //           return ListTile(
                  //             title: const Text('Sign In'),
                  //             subtitle:
                  //                 const Text('Sync your waitlist and settings'),
                  //             trailing: OutlinedButton(
                  //               onPressed: () {
                  //                 context.push('/settings/log-in');
                  //               },
                  //               child: const Text('Sign In'),
                  //             ),
                  //           );
                  //         }

                  //         return ListTile(
                  //           title: const Text('Signed In'),
                  //           subtitle: Text(
                  //               snapshot.data!.email ?? snapshot.data!.uid),
                  //           trailing: TextButton(
                  //             child: const Text('Sign Out'),
                  //             onPressed: () async {
                  //               await FirebaseAuth.instance.signOut();
                  //             },
                  //           ),
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // ),
                  const ListHeading(title: 'General'),
                  const ListTile(
                    title: Text('Country'),
                    subtitle: Text(
                      'Availability of certain stores may vary based on your country.',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 24.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(
                              Icons.arrow_drop_down_circle_sharp,
                            ),
                            onPressed: () {
                              showCountryPicker(
                                context: context,
                                useRootNavigator: true,
                                useSafeArea: true,
                                countryListTheme: CountryListThemeData(
                                  bottomSheetHeight:
                                      MediaQuery.of(context).size.height * 0.8,
                                  borderRadius: BorderRadius.zero,
                                ),
                                onSelect: (Country country) {
                                  ref
                                      .watch(asyncSettingsProvider.notifier)
                                      .setCountry(country.countryCode);
                                },
                              );
                            },
                            label: Text(
                              Country.tryParse(data.selectedCountry)?.name ??
                                  data.selectedCountry.toString().toUpperCase(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: const Text('Stores'),
                    subtitle:
                        const Text('Choose stores to retrieve prices from.'),
                    trailing: OutlinedButton.icon(
                      icon: const Icon(Icons.arrow_drop_down_circle),
                      label: Text(
                        '${selectedCount.toString()} of ${totalStores.toString()}',
                      ),
                      onPressed: () {
                        context.push('/store-select');
                      },
                    ),
                  ),
                  const ListHeading(title: 'Appearance'),
                  const DealCardTypeSettingsTile(),
                  HeaderImagesSettingsTile(
                    isEnabled: settings.value?.showHeaders ?? true,
                  ),
                  const ThemeModeListTile(),
                  const ThemeListTile(),
                  const ThemeTrueBlackListTile(),
                  const ListHeading(title: 'Waitlist'),
                  ListTile(
                    title: const Text('Import from Steam'),
                    subtitle: const Text('Import your wishlist from Steam.'),
                    trailing: OutlinedButton.icon(
                      icon: const Icon(Icons.import_export_outlined),
                      label: const Text('Import'),
                      onPressed: () {
                        context.push('/steam-import');
                      },
                    ),
                  ),
                  WaitlistAlertsSettingsTile(
                    isEnabled: settings.value?.waitlistNotifications ?? false,
                  ),
                  const ListHeading(title: 'Internal'),
                  SwitchListTile(
                    value: settings.value?.crashlyticsEnabled ?? false,
                    title: const Text('Crashlytics'),
                    subtitle: const Text('Send anonymouse crash reports.'),
                    onChanged: (value) {
                      ref
                          .read(asyncSettingsProvider.notifier)
                          .setCrashlyticsEnabled(value);
                    },
                  ),
                  ExpansionTile(
                    title: const Text('Danger Zone'),
                    children: [
                      ListTile(
                        title: const Text('Clear Waitlist'),
                        subtitle:
                            const Text('Clear all games from your waitlist.'),
                        onTap: () async {
                          showAdaptiveDialog(
                            context: context,
                            builder: (context) {
                              return ObservatoryDialog(
                                onApply: () async {
                                  ref
                                      .watch(asyncWaitListProvider.notifier)
                                      .clearWaitlist();

                                  context.pop();
                                },
                                onDiscard: () {
                                  context.pop();
                                },
                                title: 'Confirm Waitlist Clearing',
                                body:
                                    'Are you sure you want to clear your waitlist?',
                                discardText: 'Cancel',
                                applyText: 'Yes',
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  const PurchaseTile(),
                  const ListHeading(title: 'About'),
                  const AboutLinks()
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
