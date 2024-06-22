import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:observatory/shared/api/supabase_api.dart';
import 'package:observatory/shared/api/utils.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/models/igdb/igdb_game.dart';

final gameDetailsProvider =
    FutureProvider.family<GameDetails?, Deal>((ref, deal) async {
  if (deal.igdbGame != null) {
    return deal.igdbGame;
  }

  final String cleanTitle = decodeTitle(deal.titleParsed);
  final GameDetails? igdbGame = await SupabaseAPI.searchSupabase(
    id: deal.id,
    title: cleanTitle,
  );

  Logger().d({
    'igdb_data': igdbGame,
    'title': cleanTitle,
  });

  return igdbGame;
});


// @riverpod
// FutureOr<GameDetails?> igdbSearch(
//   IgdbSearchRef ref,
//   Deal deal,
// ) {
//   if (deal.igdbGame != null) {
//     return deal.igdbGame;
//   }

//   final String cleanTitle = decodeTitle(deal.titleParsed);
//   final Future<GameDetails?> igdbGame = GetIt.I<IGDBAPI>().searchSupabase(
//     id: deal.id,
//     title: cleanTitle,
//   );

//   Logger().d({
//     'igdb_data': igdbGame,
//     'title': cleanTitle,
//   });

//   return igdbGame.then((value) => value);
// }
