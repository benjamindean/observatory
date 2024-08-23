import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/settings/providers/settings_provider.dart';
import 'package:observatory/settings/settings_repository.dart';
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

    final bool showHeaders = ref.watch(
          asyncSettingsProvider.select(
            (value) => value.valueOrNull?.showHeaders,
          ),
        ) ??
        false;

    return SliverAppBar(
      toolbarHeight: 0,
      automaticallyImplyLeading: false,
      expandedHeight: showHeaders ? headerHeight : 0,
      flexibleSpace: FlexibleSpaceBar(
        background: showHeaders
            ? HeaderImage(
                url: deal.headerImageURL,
              )
            : null,
      ),
    );
  }
}
