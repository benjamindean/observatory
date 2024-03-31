import 'package:get_it/get_it.dart';
import 'package:observatory/secret_loader.dart';

final String API_IDENTIFIER = GetIt.I<Secret>().itadApiIdentifier;
final String API_KEY = GetIt.I<Secret>().itadApiKey;
final String API_SECRET = GetIt.I<Secret>().itadApiSecret;

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
