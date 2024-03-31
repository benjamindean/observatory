import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:observatory/shared/api/api.dart';
import 'package:observatory/shared/models/overview.dart';

final overviewProvider =
    FutureProvider.family<Overview?, String>((ref, id) async {
  final Overview? overview = await GetIt.I<API>().overview(ids: [id]);

  return overview?.copyWith(
    bundles: overview.bundles?.where((bundle) => !bundle.isExpired).toList(),
  );
});
