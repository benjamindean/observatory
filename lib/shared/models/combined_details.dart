import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:observatory/shared/models/game/game.dart';
import 'package:observatory/shared/models/info.dart';

part 'combined_details.freezed.dart';

@freezed
class CombinedDetails with _$CombinedDetails {
  const factory CombinedDetails({
    GameDetails? igdb,
    Info? itad,
  }) = _CombinedDetails;
}
