import 'package:http/http.dart' as http;
import 'package:sentry_flutter/sentry_flutter.dart';

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
    try {
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
        throw Exception('Wrong ns in the response');
      }

      if (split[1].endsWith('false')) {
        throw Exception('Unable to validate openId');
      }

      final String openIdUrl = data['openid.claimed_id']!;

      if (!_validation_regexp.hasMatch(openIdUrl)) {
        throw Exception('Invalid steam id pattern');
      }

      return _validation_regexp.firstMatch(openIdUrl)!.group(1)!;
    } catch (error, stackTrace) {
      Sentry.captureException(
        error,
        stackTrace: stackTrace,
      );

      return '';
    }
  }
}
