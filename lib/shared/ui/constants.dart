import 'package:observatory/settings/settings_repository.dart';

const double CARD_ELEVATION = 2.0;
const double APPBAR_ELEVATION = 2.0;

const SCREENSHOT_WIDTH = 569;
const SCREENSHOT_HEIGHT = 360;

const double SIZE_DELIMITER = 3.4;

const THUMB_WIDTH = IMAGE_WIDTH / SIZE_DELIMITER;
const THUMB_HEIGHT = IMAGE_HEIGHT / SIZE_DELIMITER;

const BASE_COMPACT_CARD_HEIGHT = 105.0;
const BASE_EXPANDED_CARD_HEIGHT = 105.0;

double cardHeight(
  bool showHeaders,
  DealCardType cardType,
  double? screenWidth,
) {
  if (cardType == DealCardType.expanded) {
    if (showHeaders && screenWidth != null) {
      return ((IMAGE_HEIGHT / IMAGE_WIDTH) * screenWidth) +
          BASE_EXPANDED_CARD_HEIGHT;
    }

    return BASE_EXPANDED_CARD_HEIGHT;
  }

  return showHeaders
      ? (IMAGE_HEIGHT / SIZE_DELIMITER) + 8
      : BASE_COMPACT_CARD_HEIGHT;
}
