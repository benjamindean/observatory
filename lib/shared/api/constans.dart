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
const API_LIMIT = 100;
const MAX_STEAM_WISHLIST_PAGES = 7;

const DEALS_COUNT = 50;
const int RECENTS_LIMIT = 10;

const Map<SortBy, String> SORT_BY_VALUES = {
  SortBy.trending: 'Trending',
  SortBy.time: 'Newest',
  SortBy.cut: 'Highest Price Cut',
  SortBy.price: 'Lowest Price',
  SortBy.expiry: 'Expiring Soon',
  SortBy.release0date: 'Release Date',
  SortBy.rank: 'Most Popular',
  SortBy.steam0players: 'Steam Players Count',
  SortBy.steam0reviews: 'Steam Reviews',
  SortBy.opencritic: 'OpenCritic Score',
  SortBy.metacritic: 'Metacritic Score',
  SortBy.metacritic0user: 'Metacritic User Score',
};

enum SortBy {
  trending,
  time,
  cut,
  price,
  expiry,
  release0date,
  rank,
  steam0reviews,
  steam0players,
  opencritic,
  metacritic,
  metacritic0user,
}
