import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:observatory/shared/api/api.dart';
import 'package:observatory/shared/api/igdb_api.dart';
import 'package:observatory/shared/models/combined_details.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/models/igdb/igdb_game.dart';
import 'package:observatory/shared/models/info.dart';

final combinedDetailsProvider = FutureProvider.family<CombinedDetails, Deal>(
  (ref, deal) async {
    final String title = deal.titleParsed;

    final Info? info = await GetIt.I<API>().info(id: deal.id);
    final List<IGDBGame>? games = await GetIt.I<IGDBAPI>().searchIGDB(
      title: title,
    );

    Logger().d({
      'igdb_names': games?.map((e) => e.name).join(','),
      'title': title,
    });

    return CombinedDetails(
      itad: info,
      igdb: games?.firstOrNull,
    );
  },
);
