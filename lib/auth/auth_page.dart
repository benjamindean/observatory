// import 'package:flutter/material.dart';
// import 'package:oauth2/oauth2.dart';
// import 'package:observatory/auth/auth_repository.dart';
// import 'package:observatory/shared/widgets/error_message.dart';

// class AuthenticationPage extends StatelessWidget {
//   final AuthenticationRepository _authRepository = AuthenticationRepository();

//   AuthenticationPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: <Widget>[
//         ErrorMessage(
//           message: 'Log In to see this page',
//           helper: TextButton(
//             child: const Text('Log In'),
//             onPressed: () async {
//               final Stream<Credentials> onCode =
//                   await _authRepository.launchAuth();

//               onCode.first.then((credentials) {
//                 // BlocProvider.of<AuthenticationBloc>(context)
//                 //     .add(LogIn(credentials));
//               });
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
