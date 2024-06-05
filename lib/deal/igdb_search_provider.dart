import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:observatory/shared/api/igdb_api.dart';
import 'package:observatory/shared/models/igdb/igdb_game.dart';

final igdbSearchProvider =
    FutureProvider.family<IGDBGame?, String>((ref, title) async {
  final List<IGDBGame>? games = await GetIt.I<IGDBAPI>().searchIGDB(
    title: title,
  );

  Logger().d({
    'igdb_names': games?.map((e) => e.name).join(','),
    'title': title,
  });

  if (games == null || games.isEmpty) {
    return null;
  }

  return games.firstOrNull;
});
