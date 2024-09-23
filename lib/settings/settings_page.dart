import 'package:observatory/auth/ui/itad_log_in_button.dart';
import 'package:observatory/bookmarks/providers/bookmarks_provider.dart';
import 'package:observatory/settings/purchase/purchase_botton.dart';
import 'package:observatory/settings/ui/about_links.dart';
import 'package:observatory/settings/ui/country_settings_list_tile.dart';
import 'package:observatory/auth/ui/steam_log_in_button.dart';
import 'package:observatory/settings/ui/stores_settings_list_tile.dart';
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
import 'package:observatory/settings/ui/header_images_settings_tile.dart';
import 'package:observatory/settings/ui/theme_mode_list_tile.dart';
import 'package:observatory/shared/widgets/error_message.dart';
import 'package:observatory/shared/widgets/list_heading.dart';
import 'package:observatory/shared/widgets/progress_indicator.dart';
import 'package:observatory/waitlist/ui/collapse_pinned_list_tile.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<SettingsState> settings = ref.watch(
      asyncSettingsProvider,
    );

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
              message: 'Failed to load settings.',
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
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const PurchaseButton(),
                  const ListHeading(title: 'General'),
                  const CountrySettingsListTile(),
                  const StoresSettingsListTile(),
                  const ListHeading(title: 'Appearance'),
                  const HeaderImagesSettingsTile(),
                  const ThemeModeListTile(),
                  const ThemeListTile(),
                  const ThemeTrueBlackListTile(),
                  const ListHeading(title: 'Waitlist'),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                    child: SteamLogInButton(),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                    child: ITADLogInButton(),
                  ),
                  const CollapsePinnedListTile(),
                  const WaitlistAlertsSettingsTile(),
                  const ListHeading(title: 'Internal'),
                  SwitchListTile(
                    value: settings.valueOrNull?.crashlyticsEnabled ?? false,
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
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return ObservatoryDialog(
                                onApply: () {
                                  ref
                                      .watch(asyncWaitListProvider.notifier)
                                      .clearWaitlist();

                                  context.pop();
                                },
                                onDiscard: () {
                                  context.pop();
                                },
                                title: 'Confirm waitlist clearing',
                                body:
                                    'Are you sure you want to clear all games from your waitlist?',
                                discardText: 'Cancel',
                                applyText: 'Yes',
                              );
                            },
                          );
                        },
                      ),
                      ListTile(
                        title: const Text('Remove Steam Imports'),
                        subtitle: const Text(
                          'Remove games imported from your Steam wishlist.',
                        ),
                        onTap: () async {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return ObservatoryDialog(
                                onApply: () {
                                  ref
                                      .watch(asyncWaitListProvider.notifier)
                                      .removeSteamImports();

                                  context.pop();
                                },
                                onDiscard: () {
                                  context.pop();
                                },
                                title: 'Confirm Steam imports removal',
                                body:
                                    'Are you sure you want to remove games imported from your Steam wishlist?',
                                discardText: 'Cancel',
                                applyText: 'Yes',
                              );
                            },
                          );
                        },
                      ),
                      ListTile(
                        title: const Text('Clear Pinned Games'),
                        subtitle: const Text(
                          'Clear all games pinned to the top of your waitlist.',
                        ),
                        onTap: () async {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return ObservatoryDialog(
                                onApply: () {
                                  ref
                                      .watch(asyncBookmarksProvider.notifier)
                                      .clearBookmarks();

                                  context.pop();
                                },
                                onDiscard: () {
                                  context.pop();
                                },
                                title: 'Confirm clearing pinned games',
                                body:
                                    'Are you sure you want to clear all games pinned to the top of your waitlist?',
                                discardText: 'Cancel',
                                applyText: 'Yes',
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  // ListTile(
                  //   title: const Text('Backup'),
                  //   trailing: TextButton.icon(
                  //     onPressed: () async {
                  //       final boxes = GetIt.I<SettingsRepository>().getBoxes();

                  //       ObservatorySnackBar.show(
                  //         context,
                  //         icon: Icons.cloud_download_rounded,
                  //         content: const Text('Starting Backup...'),
                  //       );

                  //       try {
                  //         for (final box in boxes) {
                  //           await ICloudStorage.upload(
                  //             containerId:
                  //                 'iCloud.com.benjaminabel.observatory',
                  //             filePath: box.path ?? '',
                  //             onProgress: (stream) {
                  //               stream.listen(
                  //                 (progress) {},
                  //                 onDone: () {
                  //                   ObservatorySnackBar.show(
                  //                     context,
                  //                     icon: Icons.cloud_done_rounded,
                  //                     content: const Text('Backup Complete'),
                  //                   );
                  //                 },
                  //                 onError: (err) {
                  //                   ObservatorySnackBar.show(
                  //                     context,
                  //                     icon: Icons.cloud_off_rounded,
                  //                     content: Text('Backup Failed: $err'),
                  //                   );
                  //                 },
                  //                 cancelOnError: true,
                  //               );
                  //             },
                  //           );
                  //         }
                  //       } catch (error) {
                  //         if (context.mounted) {
                  //           ObservatorySnackBar.show(
                  //             context,
                  //             icon: Icons.cloud_off_rounded,
                  //             content: Text('Backup Failed: $error'),
                  //           );
                  //         }
                  //       }
                  //     },
                  //     label: const Text('Backup Now'),
                  //     icon: const Icon(Icons.cloud_upload),
                  //   ),
                  // ),
                  // ListTile(
                  //   title: const Text('Restore Backup'),
                  //   trailing: TextButton.icon(
                  //     onPressed: () async {
                  //       final boxes = GetIt.I<SettingsRepository>().boxes;

                  //       ObservatorySnackBar.show(
                  //         context,
                  //         icon: Icons.cloud_download_rounded,
                  //         content: const Text('Starting Restore...'),
                  //       );

                  //       for (final box in boxes) {
                  //         await box.close();

                  //         final fileList = await ICloudStorage.gather(
                  //           containerId: 'iCloud.com.benjaminabel.observatory',
                  //         );

                  //         for (final file in fileList) {
                  //           await File(file.relativePath).copy(
                  //             box.path ?? '',
                  //           );
                  //         }

                  //         await Hive.openBox(box.name);
                  //       }
                  //     },
                  //     label: const Text('Restore Now'),
                  //     icon: const Icon(Icons.backup),
                  //   ),
                  // ),
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
