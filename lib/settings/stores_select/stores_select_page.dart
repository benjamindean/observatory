import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:observatory/settings/providers/itad_config_provider.dart';
import 'package:observatory/settings/stores_select/stores_list_provider.dart';
import 'package:observatory/shared/models/store.dart';
import 'package:observatory/shared/ui/observatory_back_button.dart';
import 'package:observatory/shared/ui/observatory_dialog.dart';

class StoreSelectPage extends ConsumerWidget {
  const StoreSelectPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Store> stores = ref.watch(
          itadConfigProvider.select(
            (value) => value.valueOrNull?.stores,
          ),
        ) ??
        [];
    final List<int> selectedStores = ref.watch(
          itadConfigProvider.select(
            (value) => value.valueOrNull?.selectedStores,
          ),
        ) ??
        [];

    final listProvider = storeListProvider(selectedStores);
    final List<int> storeList = ref.watch(listProvider);

    final bool hasChanged = (List.of(storeList)..sort()).join() !=
        (List.of(selectedStores)..sort()).join();

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Expanded(
              flex: 50,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                child: ObservatoryBackButton(),
              ),
            ),
            Expanded(
              flex: 50,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          useSafeArea: true,
                          context: context,
                          builder: (BuildContext context) {
                            return SafeArea(
                              child: Wrap(
                                children: [
                                  ListTile(
                                    title: Text(
                                      'Only Steam',
                                      style: context.textStyles.titleMedium,
                                    ),
                                    subtitle: Text(
                                      'Select only Steam',
                                      style: context.textStyles.bodySmall,
                                    ),
                                    onTap: () async {
                                      final int steamId = stores
                                          .where(
                                            (element) =>
                                                element.title.toLowerCase() ==
                                                'steam',
                                          )
                                          .first
                                          .id;

                                      ref
                                          .watch(listProvider.notifier)
                                          .set([steamId]);

                                      context.pop();
                                    },
                                  ),
                                  ListTile(
                                    title: Text(
                                      'Only Steam Keys',
                                      style: context.textStyles.titleMedium,
                                    ),
                                    subtitle: Text(
                                      'Select only Steam key re-sellers',
                                      style: context.textStyles.bodySmall,
                                    ),
                                    onTap: () async {
                                      final List<int> steamKeyStores = stores
                                          .where(
                                            (element) => ![
                                              'epic games store',
                                              'ea store',
                                              'gog',
                                              'ubisoft store',
                                              'microsoft store',
                                            ].contains(
                                              element.title.toLowerCase(),
                                            ),
                                          )
                                          .map((e) => e.id)
                                          .toList();

                                      ref
                                          .watch(listProvider.notifier)
                                          .set(steamKeyStores);

                                      context.pop();
                                    },
                                  ),
                                  ListTile(
                                    title: Text(
                                      'All Stores',
                                      style: context.textStyles.titleMedium,
                                    ),
                                    subtitle: Text(
                                      'Select all stores',
                                      style: context.textStyles.bodySmall,
                                    ),
                                    onTap: () async {
                                      ref.read(listProvider.notifier).set(
                                            stores.map((e) => e.id).toList(),
                                          );

                                      context.pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.filter_list),
                    ),
                    FilledButton.icon(
                      onPressed: !hasChanged
                          ? null
                          : () async {
                              await ref
                                  .read(itadConfigProvider.notifier)
                                  .setSelectedStores(storeList)
                                  .then(
                                (value) {
                                  if (context.mounted) {
                                    context.pop();
                                  }
                                },
                              );
                            },
                      icon: const Icon(Icons.check),
                      label: const Text('Apply'),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Select Stores',
          style: context.textStyles.titleMedium.copyWith(
            color: context.colors.scheme.onSurfaceVariant,
          ),
        ),
      ),
      body: Column(
        children: [
          PopScope(
            canPop: !hasChanged,
            onPopInvokedWithResult: (canPop, _) {
              if (!canPop) {
                showDialog<void>(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return ObservatoryDialog(
                      title: 'Unsaved Stores Configuration',
                      body:
                          'It looks like you have unsaved changes to your store configuration. What would you like to do?',
                      applyText: 'Save',
                      discardText: 'Discard',
                      onDiscard: () {
                        context.pop();
                        context.pop();
                      },
                      onApply: () async {
                        await ref
                            .read(itadConfigProvider.notifier)
                            .setSelectedStores(storeList)
                            .then(
                          (value) {
                            if (context.mounted) {
                              context.pop();
                              context.pop();
                            }
                          },
                        );
                      },
                    );
                  },
                );
              }
            },
            child: Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final String storeTitle = stores[index].title;
                        final int storeId = stores[index].id;

                        return CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(storeTitle),
                          value: storeList.contains(storeId),
                          enabled: storeId != 61,
                          onChanged: (value) async {
                            if (value != null) {
                              return ref
                                  .read(listProvider.notifier)
                                  .toggle(storeId, value);
                            }
                          },
                        );
                      },
                      childCount: stores.length,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
