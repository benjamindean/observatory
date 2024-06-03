import 'dart:convert';

import 'package:flutter/services.dart';

class Secret {
  final String itadApiKey;
  final String itadApiSecret;
  final String itadApiIdentifier;
  final String igdbClientId;

  Secret({
    required this.itadApiKey,
    required this.itadApiSecret,
    required this.itadApiIdentifier,
    required this.igdbClientId,
  });

  factory Secret.fromJson(Map<String, dynamic> jsonMap) {
    return Secret(
      itadApiKey: jsonMap['itad_api_key'],
      itadApiSecret: jsonMap['itad_api_secret'],
      itadApiIdentifier: jsonMap['itad_api_identifier'],
      igdbClientId: jsonMap['igdb_client_id'],
    );
  }
}

class SecretLoader {
  static Future<Secret> load() {
    return rootBundle.loadStructuredData<Secret>(
      'assets/secrets.json',
      (jsonStr) async {
        return Secret.fromJson(json.decode(jsonStr.toString()));
      },
    );
  }
}
