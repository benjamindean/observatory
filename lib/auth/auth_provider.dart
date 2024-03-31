// import 'dart:async';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:oauth2/oauth2.dart';

// import 'auth_repository.dart';
// import 'auth_state.dart';

// class AuthNotifier extends StateNotifier<AuthenticationState> {
//   AuthNotifier() : super(const AuthenticationState());

//   final AuthenticationRepository authRepository = AuthenticationRepository();

//   Future<void> writeCredentials(Credentials credentials) async {
//     await authRepository.writeCredentials(credentials);

//     state = state.copyWith(credentials: credentials);
//   }

//   Future<void> deleteCredentials() async {
//     await authRepository.deleteCredentials();

//     state = state.copyWith(credentials: null);
//   }
// }

// final authProvider =
//     StateNotifierProvider<AuthNotifier, AuthenticationState>((ref) {
//   return AuthNotifier();
// });
