import 'package:logger/logger.dart';
import 'package:observatory/shared/models/game/game.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAPI {
  static Future<GameDetails?> searchSupabase({
    required String title,
    required String id,
  }) async {
    try {
      final FunctionResponse response =
          await Supabase.instance.client.functions.invoke(
        'game-info',
        method: HttpMethod.get,
        queryParameters: {
          'id': id,
          'title': title,
        },
      );

      return response.data != null && response.data['data'] != null
          ? GameDetails.fromJson(response.data['data'])
          : null;
    } catch (error) {
      Logger().e(
        'Failed to fetch supabase search result',
        error: error,
      );

      return null;
    }
  }

  static Future<Map<String, GameDetails?>?> searchSupabaseList({
    required List<String> ids,
  }) async {
    try {
      final FunctionResponse response =
          await Supabase.instance.client.functions.invoke(
        'game-info',
        method: HttpMethod.post,
        body: {
          'ids': ids,
        },
      );

      return {
        for (var v in List.of(response.data))
          v['id']: GameDetails.fromJson(
            v['data'],
          ),
      };
    } catch (error, stackTrace) {
      Logger().e(
        'Failed to fetch supabase list search result',
        error: error,
      );

      Sentry.captureException(
        error,
        stackTrace: stackTrace,
      );

      return null;
    }
  }
}
