import 'package:flutter_config/flutter_config.dart';

final String API_IDENTIFIER = FlutterConfig.get('ITAD_API_IDENTIFIER');
final String API_KEY = FlutterConfig.get('ITAD_API_KEY');
final String API_SECRET = FlutterConfig.get('ITAD_API_SECRET');

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

const Map<String, String> DEAL_FILTERS = {
  'trending': 'All Games',
  'time': 'Newest',
  'cut': 'Highest Price Cut',
  'price': 'Lowest Price',
  'expiry': 'Expiring Soon',
  'release-date': 'Release Date',
  'rank': 'Most Popular',
  'steam-players': 'Steam Players Count',
  'steam-reviews': 'Steam Reviews',
  'opencritic': 'OpenCritic Score',
  'metacritic': 'Metacritic Score',
  'metacritic-users': 'Metacritic User Score',
};
