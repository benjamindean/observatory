import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:observatory/shared/api/api.dart';
import 'package:observatory/shared/models/history.dart';

final historyProvider =
    FutureProvider.family<List<MapEntry<int, History>>, String>(
        (ref, id) async {
  final List<MapEntry<int, History>> spots = [];
  final List<History>? history = await GetIt.I<API>().history(id: id);

  if (history == null) {
    return spots;
  }

  final List<MapEntry<int, History>> sortedHistory = {
    for (final h in history)
      DateTime.parse(h.timestamp ?? '').toLocal().millisecondsSinceEpoch: h
  }.entries.sorted((a, b) => a.key.compareTo(b.key));

  for (final entry in sortedHistory) {
    final lastSpot = spots.lastOrNull;

    if (lastSpot == null) {
      spots.add(entry);

      continue;
    }

    if (lastSpot.key > entry.key - 86400000 ||
        lastSpot.value.deal?.price.amount == entry.value.deal?.price.amount) {
      continue;
    }

    spots.add(entry);
  }

  if (spots.length < 2) {
    return [];
  }

  return spots
    ..add(
      MapEntry(
        DateTime.now().toLocal().millisecondsSinceEpoch,
        spots.last.value,
      ),
    );
});
