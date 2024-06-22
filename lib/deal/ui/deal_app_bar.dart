import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/settings/providers/settings_provider.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/context_extension.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/widgets/header_image.dart';

class DealAppBar extends ConsumerWidget {
  const DealAppBar({
    super.key,
    required this.deal,
  });

  final Deal deal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double headerHeight =
        MediaQuery.of(context).size.width / (IMAGE_WIDTH / IMAGE_HEIGHT);
    final double appBarHeight = const SliverAppBar().toolbarHeight;

    final bool showHeaders = ref.watch(
          asyncSettingsProvider.select(
            (value) => value.valueOrNull?.showHeaders,
          ),
        ) ??
        false;

    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      expandedHeight: showHeaders ? headerHeight + appBarHeight : appBarHeight,
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1,
        titlePadding: EdgeInsets.zero,
        title: Container(
          color: context.elevatedBottomAppBarColor,
          child: ListTile(
            title: Tooltip(
              message: deal.titleParsed,
              child: Text(
                deal.titleParsed,
                maxLines: 1,
                style: TextStyle(
                  fontSize: context.themes.text.titleMedium?.fontSize,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
        background: showHeaders
            ? Padding(
                padding: EdgeInsets.only(
                  bottom: appBarHeight,
                ),
                child: HeaderImage(
                  url: deal.headerImageURL,
                ),
              )
            : null,
      ),
    );
  }
}
