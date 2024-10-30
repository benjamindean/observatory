import 'package:flutter_dotenv/flutter_dotenv.dart';

final String API_IDENTIFIER = dotenv.get('ITAD_API_IDENTIFIER');
final String API_KEY = dotenv.get('ITAD_API_KEY');
final String API_SECRET = dotenv.get('ITAD_API_SECRET');

const List<String> API_SCOPES = [
  'user_info',
  'wait_read',
  'wait_write',
  'coll_read',
  'coll_write',
];
const String BASE_URL = 'api.isthereanydeal.com';
const String REDIRECT_URL = 'https://observatory-bc08e.web.app/';
const int API_LIMIT = 100;
const int MAX_STEAM_WISHLIST_PAGES = 7;

const int DEALS_COUNT = 50;
const int RECENTS_LIMIT = 10;
const double THUMBNAIL_DELIMITER = 2.5;

const int IMAGE_WIDTH = 600;
const int IMAGE_HEIGHT = 344;

const int SCREENSHOT_WIDTH = 569;
const int SCREENSHOT_HEIGHT = 360;

const double SIZE_DELIMITER = 3.4;

const double THUMB_WIDTH = IMAGE_WIDTH / SIZE_DELIMITER;
const double THUMB_HEIGHT = IMAGE_HEIGHT / SIZE_DELIMITER;

const BASE_CARD_HEIGHT = 100.0;

const Map<SortDealsBy, String> SORT_BY_FILTER_STRINGS = {
  SortDealsBy.trending: '-trending',
  SortDealsBy.time: '-time',
  SortDealsBy.cut: '-cut',
  SortDealsBy.price: 'price',
  SortDealsBy.releasedate: '-release-date',
  SortDealsBy.rank: 'rank',
  SortDealsBy.steamplayers: '-steam-players',
  SortDealsBy.steamreviews: '-steam-reviews',
  SortDealsBy.metacritic: '-metacritic',
  SortDealsBy.metacriticuser: '-metacritic-user',
};

const Map<SortDealsBy, String> SORT_BY_VALUES = {
  SortDealsBy.trending: 'Trending',
  SortDealsBy.time: 'Newest',
  SortDealsBy.cut: 'Highest Price Cut',
  SortDealsBy.price: 'Lowest Price',
  SortDealsBy.releasedate: 'Release Date',
  SortDealsBy.rank: 'Most Popular',
  SortDealsBy.steamplayers: 'Steam Players',
  SortDealsBy.steamreviews: 'Steam Reviews',
  SortDealsBy.metacritic: 'Metacritic Score',
  SortDealsBy.metacriticuser: 'Metacritic User Score',
};

enum SortDealsBy {
  trending,
  time,
  cut,
  price,
  releasedate,
  rank,
  steamreviews,
  steamplayers,
  metacritic,
  metacriticuser,
}
