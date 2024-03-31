// import 'dart:async';
// import 'dart:math';

// import 'package:oauth2/oauth2.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:uni_links/uni_links.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../shared/api/constans.dart';

// class AuthenticationRepository {
//   final Uri redirectUrl = Uri.parse(REDIRECT_URL);
//   final Uri authorizationEndpoint = Uri.parse(
//     'https://isthereanydeal.com/oauth/authorize/',
//   );
//   final Uri tokenEndpoint = Uri.parse(
//     'https://isthereanydeal.com/oauth/token/',
//   );

//   late StreamSubscription authStream;
//   late AuthorizationCodeGrant grant;
//   late Uri authURL;
//   static const String _charset =
//       'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~';

//   AuthenticationRepository() {
//     grant = AuthorizationCodeGrant(
//       API_IDENTIFIER,
//       authorizationEndpoint,
//       tokenEndpoint,
//       secret: API_SECRET,
//       codeVerifier: List.generate(
//         128,
//         (i) => _charset[Random.secure().nextInt(_charset.length)],
//       ).join(),
//     );

//     authURL = grant.getAuthorizationUrl(
//       redirectUrl,
//       state: 'IsThereAnyState',
//       scopes: API_SCOPES,
//     );
//   }

//   Future<Credentials> authorize(String params) async {
//     final Client client = await grant.handleAuthorizationCode(params);

//     await writeCredentials(client.credentials);

//     return client.credentials;
//   }

//   Future<bool> deleteCredentials() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();

//     return prefs.remove('authorization');
//   }

//   Future<Credentials?> getCredentials() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final credentials = prefs.getString('authorization');

//     if (credentials != null) {
//       return Credentials.fromJson(credentials);
//     }

//     return null;
//   }

//   Future<Stream<Credentials>> launchAuth() async {
//     final StreamController<Credentials> onCode = StreamController();

//     authStream = linkStream.listen(
//       (String? link) {
//         if (link == null) {
//           return;
//         }

//         Uri uri = Uri.parse(link);

//         authorize(uri.queryParameters.toString()).then(
//           (credentials) {
//             onCode.add(credentials);
//             onCode.close();
//             authStream.cancel();
//           },
//         );
//       },
//       onError: (err) {
//         onCode.close();
//         authStream.cancel();
//       },
//       onDone: () {
//         onCode.close();
//         authStream.cancel();
//       },
//     );

//     launchUrl(authURL);

//     return onCode.stream;
//   }

//   Future<bool> writeCredentials(Credentials credentials) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();

//     return prefs.setString('authorization', credentials.toJson());
//   }
// }
