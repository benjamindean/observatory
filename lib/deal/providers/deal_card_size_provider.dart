import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/settings/providers/settings_provider.dart';
import 'package:observatory/shared/constans.dart';

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

    return showHeaders ? (IMAGE_HEIGHT / SIZE_DELIMITER) + 8 : BASE_CARD_HEIGHT;
  }
}

final dealCardSizeProvider = NotifierProvider<DealCardSizeProvider, double>(
  DealCardSizeProvider.new,
);
