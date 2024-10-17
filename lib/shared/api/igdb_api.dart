import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/api/parsers.dart';
import 'package:observatory/shared/api/utils.dart';
import 'package:observatory/shared/models/game/game.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class IGDBAPI {
  final Dio dio;
  final CacheOptions cacheOptions;
  final SettingsRepository settingsReporsitory = GetIt.I<SettingsRepository>();

  IGDBAPI({
    required this.dio,
    required this.cacheOptions,
  });

  static IGDBAPI create(String? directory) {
    final options = CacheOptions(
      store: HiveCacheStore(
        directory,
        hiveBoxName: 'observatory_dio_cache',
      ),
      policy: CachePolicy.forceCache,
      priority: CachePriority.high,
      hitCacheOnErrorExcept: [401, 404],
      maxStale: const Duration(days: 14),
      allowPostMethod: true,
      keyBuilder: (request) {
        return const Uuid().v5(
          Namespace.url.uuidValue.uuid,
          request.uri.toString() + request.data.toString(),
        );
      },
    );

    final Dio dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.igdb.com',
        responseType: ResponseType.json,
      ),
    )..interceptors.add(DioCacheInterceptor(options: options));

    return IGDBAPI(
      dio: dio,
      cacheOptions: options,
    );
  }

  Future<List<GameDetails>?> searchIGDB({
    required String title,
  }) async {
    try {
      final IGDBAccessToken? token = await getIGDBToken();
      final String cleanTitle = decodeTitle(title);

      final response = await dio.post(
          options: cacheOptions.toOptions().copyWith(
            headers: {
              'Client-ID': dotenv.get('IGDB_CLIENT_ID'),
              'Authorization': 'Bearer ${token?.token}',
            },
          ),
          '/v4/search',
          data: [
            'search "$cleanTitle";',
            'where game.name ~ "$cleanTitle" | name ~ "$cleanTitle";',
            'fields',
            'game.genres.id,',
            'game.genres.name,',
            'game.genres.slug,',
            'game.involved_companies.company.id,',
            'game.involved_companies.company.name,',
            'game.involved_companies.company.s ug,',
            'game.name,',
            'game.first_release_date,',
            'game.summary,',
            'game.themes.id,',
            'game.themes.name,',
            'game.themes.slug,',
            'game.url,',
            'game.screenshots.id,',
            'game.screenshots.width,',
            'game.screenshots.height,',
            'game.screenshots.image_id,',
            'game.screenshots.url,',
            'game.websites.id,',
            'game.websites.url,',
            'game.videos.id,',
            'game.videos.name,',
            'game.videos.video_id,',
            'game.similar_games.id,',
            'game.platforms.id,',
            'game.platforms.name,',
            'game.platforms.abbreviation;',
          ].join(' '));

      return Parsers.igdbSearchResult(response.data);
    } catch (error, stackTrace) {
      Logger().e(
        'Failed to fetch IGDB search result',
        error: error,
      );

      Sentry.captureException(
        error,
        stackTrace: stackTrace,
      );

      return null;
    }
  }

  Future<IGDBAccessToken?> getIGDBToken() async {
    final IGDBAccessToken? cachedToken =
        await settingsReporsitory.getIGDBAccessToken();

    if (cachedToken != null) {
      final double currentDate = DateTime.now().millisecondsSinceEpoch / 1000;
      final bool isExpired =
          cachedToken.expires_at < currentDate + 60 * 60 * 24;

      if (isExpired) {
        return await getNewIGDBToken();
      }

      return cachedToken;
    }

    return await getNewIGDBToken();
  }

  Future<IGDBAccessToken?> getNewIGDBToken() async {
    final tokenData =
        await Supabase.instance.client.functions.invoke('get-igdb-token');
    final IGDBAccessToken token = IGDBAccessToken.fromJson(tokenData.data);

    await settingsReporsitory.setIGDBAccessToken(token);

    return token;
  }
}
