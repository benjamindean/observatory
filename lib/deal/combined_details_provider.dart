import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:observatory/shared/api/api.dart';
import 'package:observatory/shared/api/igdb_api.dart';
import 'package:observatory/shared/models/combined_details.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/models/igdb/igdb_game.dart';
import 'package:observatory/shared/models/info.dart';

final combinedDetailsProvider = FutureProvider.family<CombinedDetails, Deal>(
  (ref, deal) async {
    final Info? info = await GetIt.I<API>().info(id: deal.id);
    final List<IGDBGame>? games = await GetIt.I<IGDBAPI>().searchIGDB(
      title: deal.titleParsed,
    );

    return CombinedDetails(
      itad: info,
      igdb: games?.firstOrNull,
    );
  },
);
