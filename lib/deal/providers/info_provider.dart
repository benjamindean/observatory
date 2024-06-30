import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:observatory/shared/api/api.dart';
import 'package:observatory/shared/models/info.dart';

final infoProvider = FutureProvider.family<Info?, String>((ref, id) async {
  return GetIt.I<API>().info(id: id);
});
