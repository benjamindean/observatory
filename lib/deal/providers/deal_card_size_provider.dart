import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/settings/providers/settings_provider.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/ui/constants.dart';

class DealCardSizeProvider extends Notifier<double> {
  @override
  double build() {
    return BASE_CARD_HEIGHT;
  }

  double getHeight(double? screenWidth) {
    final bool showHeaders = ref.watch(
      asyncSettingsProvider.select(
        (value) => value.valueOrNull?.showHeaders ?? false,
      ),
    );
    final DealCardType cardType = ref.watch(
      asyncSettingsProvider.select(
        (value) => value.valueOrNull?.dealCardType ?? DealCardType.compact,
      ),
    );

    if (cardType == DealCardType.expanded) {
      if (showHeaders && screenWidth != null) {
        return ((IMAGE_HEIGHT / IMAGE_WIDTH) * screenWidth) + BASE_CARD_HEIGHT;
      }

      return BASE_CARD_HEIGHT + 8;
    }

    return showHeaders ? (IMAGE_HEIGHT / SIZE_DELIMITER) + 8 : BASE_CARD_HEIGHT;
  }
}

final dealCardSizeProvider = NotifierProvider<DealCardSizeProvider, double>(
  DealCardSizeProvider.new,
);
