import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:observatory/shared/models/region.dart';

class RegionSelect extends ConsumerWidget {
  final List<Region> regions;

  const RegionSelect({
    super.key,
    required this.regions,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: regions.length,
            itemBuilder: (context, index) {
              return ListTile(
                selectedTileColor: context.colors.scheme.primaryContainer,
                selectedColor: context.colors.scheme.onPrimaryContainer,
                title: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(regions[index].code.toUpperCase()),
                    ),
                    Text(
                      '${regions[index].currency.sign} ${regions[index].currency.code}',
                      style: context.themes.text.labelSmall?.copyWith(
                        color: context.colors.scheme.onSurfaceVariant,
                      ),
                    )
                  ],
                ),
                subtitle: Text(
                  regions[index]
                      .countries
                      .map(
                        (e) =>
                            Country.tryParse(e.toUpperCase())?.name ??
                            e.toUpperCase(),
                      )
                      .toList()
                      .join(', '),
                ),
                onTap: () async {
                  // ref.read(asyncSettingsProvider.notifier).setRegion(
                  //       regions[index].code,
                  //     );

                  context.pop();
                },
              );
            },
          )
        ],
      ),
    );
  }
}
