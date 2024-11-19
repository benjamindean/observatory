import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:observatory/shared/api/api.dart';
import 'package:observatory/shared/models/history.dart';

final historyProvider =
    FutureProvider.family<List<History>, String>((ref, id) async {
  return await GetIt.I<API>().history(id: id);
});
