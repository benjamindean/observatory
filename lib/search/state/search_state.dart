import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_state.freezed.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState({
    required String? query,
    @Default(false) bool isOpen,
    @Default(false) bool isLoading,
    required FocusNode focusNode,
    required TextEditingController searchInputController,
  }) = _SearchState;
}
