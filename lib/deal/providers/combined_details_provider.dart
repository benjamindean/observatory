import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:observatory/deal/providers/game_details_provider.dart';
import 'package:observatory/shared/api/api.dart';
import 'package:observatory/shared/models/combined_details.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/models/igdb/igdb_game.dart';
import 'package:observatory/shared/models/info.dart';

final combinedDetailsProvider = FutureProvider.family<CombinedDetails, Deal>(
  (ref, deal) async {
    final GameDetails? gameDetails = ref
        .watch(
          gameDetailsProvider(deal),
        )
        .valueOrNull;

    final Info? info = await GetIt.I<API>().info(id: deal.id);

    Logger().d({
      'game_details': gameDetails,
      'title': deal.titleParsed,
    });

    return CombinedDetails(
      itad: info,
      igdb: gameDetails,
    );
  },
);
