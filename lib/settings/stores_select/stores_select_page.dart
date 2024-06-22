import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:observatory/router.dart';
import 'package:observatory/settings/providers/settings_provider.dart';
import 'package:observatory/settings/stores_select/stores_list_provider.dart';
import 'package:observatory/shared/models/store.dart';
import 'package:observatory/shared/ui/constants.dart';
import 'package:observatory/shared/ui/observatory_back_button.dart';
import 'package:observatory/shared/ui/observatory_dialog.dart';

class StoreSelectPage extends ConsumerWidget {
  const StoreSelectPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Store> stores = ref.watch(
          asyncSettingsProvider.select(
            (value) => value.valueOrNull?.stores,
          ),
        ) ??
        [];
    final List<int> selectedStores = ref.watch(
          asyncSettingsProvider.select(
            (value) => value.valueOrNull?.selectedStores,
          ),
        ) ??
        [];

    final listProvider = storeListProvider(selectedStores);
    final List<int> storeList = ref.watch(listProvider);

    final bool hasChanged = (List.from(storeList)..sort()).join() !=
        (List.from(selectedStores)..sort()).join();

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        elevation: APPBAR_ELEVATION,
        surfaceTintColor: context.colors.scheme.surfaceTint,
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
                          context: rootNavigatorKey.currentContext!,
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
                                      'All Stores',
                                      style: context.textStyles.titleMedium,
                                    ),
                                    subtitle: Text(
                                      'Select all stores',
                                      style: context.textStyles.bodySmall,
                                    ),
                                    onTap: () async {
                                      ref.watch(listProvider.notifier).set(
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
                                  .read(asyncSettingsProvider.notifier)
                                  .setSelectedStores(storeList)
                                  .then((value) => context.pop());
                            },
                      icon: const Icon(Icons.save),
                      label: const Text('Save'),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Select Stores'),
      ),
      body: Column(
        children: [
          PopScope(
            canPop: !hasChanged,
            onPopInvoked: (canPop) {
              if (!canPop) {
                showAdaptiveDialog<void>(
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
                            .read(asyncSettingsProvider.notifier)
                            .setSelectedStores(storeList)
                            .then(
                          (value) {
                            context.pop();
                            context.pop();
                          },
                        );
                      },
                    );
                  },
                );
              }
            },
            child: Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: stores.length,
                itemBuilder: (context, index) {
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
              ),
            ),
          )
        ],
      ),
    );
  }
}
