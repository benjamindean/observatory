import 'package:http/http.dart' as http;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class OpenId {
  final _steam_login = 'https://steamcommunity.com/openid/login';

  static const _openIdMode = 'checkid_setup';
  static const _openIdNs = 'http://specs.openid.net/auth/2.0';
  static const _openIdIdentifier =
      'http://specs.openid.net/auth/2.0/identifier_select';

  static final RegExp _validation_regexp = RegExp(
    r'^https://steamcommunity.com/openid/id/(7[0-9]{15,25})$',
  );

  final String host = 'https://getobservatory.app';
  final String returnUrl = 'https://getobservatory.app/app/auth/steam';

  const OpenId();

  Uri authUrl() {
    return Uri.https(
      'steamcommunity.com',
      '/openid/login',
      {
        'openid.claimed_id': _openIdIdentifier,
        'openid.identity': _openIdIdentifier,
        'openid.mode': _openIdMode,
        'openid.ns': _openIdNs,
        'openid.realm': host,
        'openid.return_to': returnUrl
      },
    );
  }

  Future<String> validate(Map<String, String> data) async {
    Map<String, String?> params = {
      'openid.assoc_handle': data['openid.assoc_handle'],
      'openid.signed': data['openid.signed'],
      'openid.sig': data['openid.sig'],
      'openid.ns': data['openid.ns']
    };

    List<String> split = data['openid.signed']!.split(',');

    for (final part in split) {
      params['openid.$part'] = data['openid.$part'];
    }

    params['openid.mode'] = 'check_authentication';

    final resp = await http.post(
      Uri.parse(_steam_login),
      body: params,
    );

    split = resp.body.split('\n');

    if (split[0] != 'ns:$_openIdNs') {
      FirebaseCrashlytics.instance.recordError(
        Exception('Wrong ns in the response'),
        StackTrace.current,
      );

      throw Exception('Wrong ns in the response');
    }

    if (split[1].endsWith('false')) {
      FirebaseCrashlytics.instance.recordError(
        Exception('Unable to validate openId'),
        StackTrace.current,
      );

      throw Exception('Unable to validate openId');
    }

    final String openIdUrl = data['openid.claimed_id']!;

    if (!_validation_regexp.hasMatch(openIdUrl)) {
      FirebaseCrashlytics.instance.recordError(
        Exception('Invalid steam id pattern'),
        StackTrace.current,
      );

      throw Exception('Invalid steam id pattern');
    }

    return _validation_regexp.firstMatch(openIdUrl)!.group(1)!;
  }
}
