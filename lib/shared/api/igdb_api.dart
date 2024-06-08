import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:observatory/secret_loader.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/api/parsers.dart';
import 'package:observatory/shared/models/igdb/igdb_game.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
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
          Uuid.NAMESPACE_URL,
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

  Future<List<IGDBGame>?> searchIGDB({
    required String title,
  }) async {
    try {
      final IGDBAccessToken? token = await getIGDBToken();
      final String cleanTitle = const AsciiDecoder().convert(
        utf8.encode(
          title.replaceAll(RegExp(r"[^A-Za-z0-9().,'&;?/:]+"), ' ').trim(),
        ),
      );

      final response = await dio.post(
        options: cacheOptions.toOptions().copyWith(
          headers: {
            'Client-ID': GetIt.I<Secret>().igdbClientId,
            'Authorization': 'Bearer ${token?.token}',
          },
        ),
        '/v4/search',
        data: [
          'search "$cleanTitle";',
          'where game != null & game.name ~ "$cleanTitle" | name ~ "$cleanTitle";',
          'fields',
          'game.id,',
          'game.name,',
          'game.summary,',
          'game.first_release_date,',
          'game.themes.*,',
          'game.storyline,',
          'game.url,',
          'game.screenshots.*,',
          'game.websites.*,',
          'game.videos.*,',
          'game.platforms.*;',
        ].join(' '),
      );

      return Parsers.igdbSearchResult(response.data);
    } catch (error, stackTrace) {
      Logger().e(
        'Failed to fetch IGDB search result',
        error: error,
      );

      FirebaseCrashlytics.instance.recordError(
        error,
        stackTrace,
      );

      return null;
    }
  }

  Future<IGDBAccessToken?> getIGDBToken() async {
    final IGDBAccessToken? cachedToken =
        settingsReporsitory.getIGDBAccessToken();

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
