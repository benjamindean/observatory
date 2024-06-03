import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:observatory/deal/overview_provider.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/models/overview.dart';
import 'package:url_launcher/url_launcher.dart';

class BundlesTile extends ConsumerWidget {
  final Deal deal;

  const BundlesTile({
    super.key,
    required this.deal,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Overview?> overviewState = ref.watch(
      overviewProvider(deal.id),
    );
    final bool isEnabled = overviewState.value?.bundles?.isNotEmpty ?? false;

    return IgnorePointer(
      ignoring: !isEnabled,
      child: ListTileTheme(
        child: ExpansionTile(
          trailing: isEnabled ? null : const SizedBox.shrink(),
          title: Padding(
            padding: const EdgeInsets.only(
              bottom: 2.0,
            ),
            child: Text(
              'Bundles',
              style: context.themes.text.labelLarge?.copyWith(
                color: context.colors.hint,
              ),
            ),
          ),
          subtitle: AnimatedSwitcher(
            layoutBuilder: (
              Widget? currentChild,
              List<Widget> previousChildren,
            ) {
              return Stack(
                alignment: Alignment.centerLeft,
                children: <Widget>[
                  ...previousChildren,
                  if (currentChild != null) currentChild,
                ],
              );
            },
            duration: const Duration(milliseconds: 200),
            child: overviewState.when(
              data: (data) {
                final List<Bundle>? bundles = data?.bundles;

                if (bundles == null || bundles.isEmpty) {
                  return Text(
                    'This game is not currently a part of any bundle.',
                    style: context.themes.text.labelLarge?.copyWith(
                      color: context.colors.disabled,
                    ),
                  );
                }

                return Text(
                  '${bundles.length} ${Intl.plural(bundles.length, one: 'bundle', other: 'bundles')} currently available!',
                  style: context.themes.text.labelLarge?.copyWith(
                    color: context.colors.scheme.onSurface,
                  ),
                );
              },
              error: (error, stackTrace) {
                Logger().e(
                  'Failed to load overview',
                  error: error,
                  stackTrace: stackTrace,
                );

                FirebaseCrashlytics.instance.recordError(
                  error,
                  stackTrace,
                );

                return Text(
                  'This game is not currently bundled',
                  style: context.themes.text.labelLarge?.copyWith(
                    color: context.colors.scheme.onSurface,
                  ),
                );
              },
              loading: () {
                return LinearProgressIndicator(
                  borderRadius: BorderRadius.circular(12.0),
                  minHeight: 2,
                  color: context.colors.scheme.onSurfaceVariant,
                );
              },
            ),
          ),
          children: overviewState.when(
            data: (data) {
              final List<Bundle>? bundles = data?.bundles;

              if (bundles == null || bundles.isEmpty) {
                return [];
              }

              return bundles
                  .map(
                    (bundle) => ListTile(
                      title: Text(bundle.title),
                      subtitle: Text(
                        bundle.page.name.toString(),
                      ),
                      trailing:
                          const FaIcon(FontAwesomeIcons.squareArrowUpRight),
                      onTap: () {
                        launchUrl(
                          Uri.parse(bundle.url),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                    ),
                  )
                  .toList();
            },
            error: (error, stackTrace) {
              Logger().e(
                'Failed to load overview',
                error: error,
                stackTrace: stackTrace,
              );

              FirebaseCrashlytics.instance.recordError(
                error,
                stackTrace,
              );

              return [];
            },
            loading: () {
              return [];
            },
          ),
        ),
      ),
    );
  }
}
