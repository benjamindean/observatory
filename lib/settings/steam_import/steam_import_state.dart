import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:observatory/shared/models/deal.dart';

part 'steam_import_state.freezed.dart';

@freezed
class SteamImportState with _$SteamImportState {
  const factory SteamImportState({
    String? username,
    List<Deal>? deals,
    @Default([]) List<Deal> selectedDeals,
    String? error,
    @Default(false) bool isLoading,
    @Default(false) bool isImporting,
    required FocusNode focusNode,
    required TextEditingController usernameInputController,
  }) = _SteamImportState;
}
