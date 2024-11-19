import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:observatory/search/providers/search_provider.dart';
import 'package:observatory/search/state/search_state.dart';
import 'package:observatory/search/ui/search_input.dart';
import 'package:observatory/shared/ui/ory_small_button.dart';
import 'package:observatory/shared/widgets/settings_button.dart';

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({
    required this.milliseconds,
  });

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(
      Duration(milliseconds: milliseconds),
      action,
    );
  }

  void dispose() {
    _timer?.cancel();
  }
}

final Debouncer debouncer = Debouncer(milliseconds: 700);

class SearchAppBar extends ConsumerWidget {
  const SearchAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SearchState searchState = ref.watch(dealSearchProvider);

    if (searchState.isOpen) {
      return SliverAppBar(
        floating: true,
        titleSpacing: 0.0,
        title: SearchInput(
          searchType: SearchType.search,
          onSubmitted: (String value) {
            if (value.trim().isNotEmpty) {
              ref.read(dealSearchProvider.notifier).performSearch(value.trim());
            }
          },
        ),
      );
    }

    return SliverAppBar(
      floating: true,
      actions: <Widget>[
        OrySmallButton(
          onPressed: () {
            ref.read(dealSearchProvider.notifier).setIsOpen();
          },
          icon: Icons.search,
          label: 'Search',
        ),
        const SettingsButton(),
      ],
    );
  }
}
