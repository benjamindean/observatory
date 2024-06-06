import 'dart:convert';

import 'package:observatory/shared/models/chart_entry.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/models/igdb/igdb_game.dart';
import 'package:observatory/shared/models/info.dart';
import 'package:observatory/shared/models/overview.dart';
import 'package:observatory/shared/models/price.dart';
import 'package:observatory/shared/models/steam_featured_item.dart';
import 'package:observatory/shared/models/store.dart';

class Parsers {
  static Info info(contents) {
    final Map<String, dynamic> jsonResponse = json.decode(contents.toString());

    return Info.fromJson(jsonResponse);
  }

  static Overview overview(contents) {
    final Map<String, dynamic> jsonResponse = json.decode(contents.toString());

    return Overview.fromJson(jsonResponse);
  }

  static Map<String, List<Price>> prices(contents) {
    final Map<String, List<Price>> mapOfPrices = {};
    final List<dynamic> rawList = json.decode(contents.toString());

    for (final deal in rawList) {
      if (deal['deals'] != null && deal['deals'].length > 0) {
        deal['deals'].forEach((price) {
          mapOfPrices.putIfAbsent(deal['id'], () => []);
          mapOfPrices[deal['id']]?.add(
            Price.fromJson(price).copyWith(
              timestampMs: DateTime.tryParse(
                price['timestamp'],
              )?.millisecondsSinceEpoch,
            ),
          );
        });
      }
    }

    return mapOfPrices;
  }

  static List<Store> stores(contents) {
    final jsonResponse = json.decode(contents.toString());

    return jsonResponse.map<Store>((e) => Store.fromJson(e)).toList();
  }

  static List<Deal> deals(contents) {
    final List<dynamic> rawList = json.decode(contents.toString())['list'];

    return rawList.map<Deal>((deal) => Deal.fromJson(deal)).toList();
  }

  static List<Deal> searchResults(contents) {
    final List<dynamic> rawList = json.decode(contents.toString());

    return rawList.map<Deal>((deal) => Deal.fromJson(deal)).toList();
  }

  static List<ChartEntry> popularityChart(contents) {
    final List<dynamic> rawList = json.decode(contents.toString())['data'];

    return rawList.map((result) => ChartEntry.fromJson(result)).toList();
  }

  static List<SteamFeaturedItem> steamStoreFront(contents) {
    final response = json.decode(contents.toString());

    final List<dynamic> specials = response['specials']['items'];
    final List<dynamic> topSellers = response['top_sellers']['items'];
    final List<dynamic> comingSoon = response['coming_soon']['items'];
    final List<dynamic> newReleases = response['new_releases']['items'];

    return [...specials, ...topSellers, ...comingSoon, ...newReleases]
        .map((result) => SteamFeaturedItem.fromJson(result))
        .toSet()
        .toList();
  }

  static List<SteamFeaturedItem> steamFeatured(contents) {
    final response = json.decode(contents.toString());

    final List<dynamic> specials = response['large_capsules'];
    final List<dynamic> featuredWin = response['featured_win'];
    final List<dynamic> featuredMac = response['featured_mac'];
    final List<dynamic> featuredLinux = response['featured_linux'];

    return [...specials, ...featuredWin, ...featuredMac, ...featuredLinux]
        .map((result) => SteamFeaturedItem.fromJson(result))
        .toSet()
        .toList();
  }

  static List<IGDBGame>? igdbSearchResult(contents) {
    if (contents == null || contents.isEmpty) {
      return null;
    }

    return List.from(contents)
        .map(
          (result) => result['game'] != null
              ? IGDBGame.fromJson(result['game'])
              : const IGDBGame(id: -1),
        )
        .where((element) => element.id != -1)
        .toList();
  }
}
