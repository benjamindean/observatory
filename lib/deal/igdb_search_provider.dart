import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:observatory/shared/api/igdb_api.dart';
import 'package:observatory/shared/models/igdb/igdb_game.dart';

String cleanTitle(String? title) {
  if (title == null) {
    return '';
  }

  return title
      .toLowerCase()
      .trim()
      .replaceAll(RegExp(r'[^\w\s]+'), '')
      .replaceAll(' ', '');
}

final igdbSearchProvider =
    FutureProvider.family<IGDBGame?, String>((ref, title) async {
  final List<IGDBGame>? games = await GetIt.I<IGDBAPI>().searchIGDB(
    title: title,
  );

  Logger().d({
    'igdb_names': games?.map((e) => cleanTitle(e.name)).join(','),
    'title': cleanTitle(title),
  });

  if (games == null || games.isEmpty) {
    return null;
  }

  return games.firstWhereOrNull(
    (element) => cleanTitle(element.name) == cleanTitle(title),
  );
});
