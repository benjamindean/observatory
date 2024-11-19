import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:observatory/shared/api/api.dart';
import 'package:observatory/shared/api/utils.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/models/game/game.dart';

final gameDetailsProvider =
    FutureProvider.family<GameDetails?, Deal>((ref, deal) async {
  final String cleanTitle = decodeTitle(deal.titleParsed);
  final GameDetails? gameDetails = await GetIt.I<API>().gameDetails(
    id: deal.id,
    title: cleanTitle,
  );

  Logger().d({
    'igdb_data': gameDetails,
    'title': cleanTitle,
  });

  return gameDetails;
});
