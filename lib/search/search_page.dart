import 'package:flutter/material.dart';
import 'package:observatory/search/search_list.dart';
import 'package:observatory/search/ui/search_appbar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SearchAppBar(),
        SearchList(),
      ],
    );
  }
}
