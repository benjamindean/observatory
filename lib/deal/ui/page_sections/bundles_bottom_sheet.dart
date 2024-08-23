import 'package:flutter/material.dart';
import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:observatory/shared/models/overview.dart';
import 'package:observatory/shared/ui/bottom_sheet_container.dart';
import 'package:observatory/shared/ui/bottom_sheet_heading.dart';
import 'package:observatory/shared/ui/backdrop_container.dart';
import 'package:url_launcher/url_launcher.dart';

void showBundlesBottomSheet(BuildContext context, List<Bundle> bundles) {
  showModalBottomSheet(
    useRootNavigator: true,
    useSafeArea: true,
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return BundlesBottomSheet(
        bundles: bundles,
      );
    },
  );
}

class BundlesBottomSheet extends StatelessWidget {
  final List<Bundle> bundles;

  const BundlesBottomSheet({
    super.key,
    required this.bundles,
  });

  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BottomSheetHeading(text: 'Bundles'),
            BackdropContainer(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: bundles.length,
                itemBuilder: (context, index) {
                  final Bundle bundle = bundles[index];

                  return ListTile(
                    onTap: () async {
                      launchUrl(
                        Uri.parse(bundle.url),
                        mode: LaunchMode.externalApplication,
                      );
                    },
                    title: Text(
                      bundle.title,
                      style: context.textStyles.titleMedium.copyWith(
                        color: context.colors.scheme.onSurface,
                      ),
                    ),
                    subtitle: Text(
                      bundle.page.name,
                      style: context.textStyles.bodySmall.copyWith(
                        color: context.colors.scheme.onSurface,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
